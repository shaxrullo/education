import 'package:education/Bloc/Category/category_bloc.dart';
import 'package:education/Bloc/Courses/courses_bloc.dart';
import 'package:education/Model/CategoryModel.dart';
import 'package:education/Model/CoursesModel.dart';
import 'package:education/app/theme/app_colors.dart';
import 'package:education/app/theme/app_text_styles.dart';
import 'package:education/screens/course_detail/course_detail_screen.dart';
import 'package:education/widgets/category_card.dart';
import 'package:education/widgets/course_card.dart';
import 'package:education/widgets/custom_text_field.dart';
import 'package:education/widgets/empty_error_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final _searchController = TextEditingController();
  int _selectedCategoryIndex = -1; // -1 = All
  String _selectedLevel = 'All';
  String _searchQuery = '';

  // 1-tuzatish: bu endi doim ikkita argument bilan chaqiriladi,
  // getter emas, oddiy metod sifatida ishlatiladi
  List<CourseModel> _filterCourses(
    List<CourseModel> courses,
    List<CategoryModel> categories,
  ) {
    return courses.where((course) {
      final matchCategory =
          _selectedCategoryIndex == -1 ||
          (categories.isNotEmpty &&
              _selectedCategoryIndex < categories.length &&
              course.category.id == categories[_selectedCategoryIndex].id);
      final matchLevel =
          _selectedLevel == 'All' || course.level == _selectedLevel;
      final matchSearch =
          _searchQuery.isEmpty ||
          course.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          course.teacher.name.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      return matchCategory && matchLevel && matchSearch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(CategoryRequested());
    // 2-tuzatish: kurslarni yuklash eventi qo'shildi — bu bo'lmasa
    // CourseBloc hech qachon ma'lumot olib kelmaydi
    context.read<CoursesBloc>().add(CoursesRequested());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        // 3-tuzatish: ikkala bloc bitta joyda o'qilib, filtrlangan ro'yxat
        // header va list ikkalasiga ham beriladi — ikki marta hisoblanmaydi
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, categoryState) {
            final categories = categoryState is CategoryLoaded
                ? categoryState.categories
                : <CategoryModel>[];

            return BlocBuilder<CoursesBloc, CoursesState>(
              builder: (context, courseState) {
                final allCourses = courseState is CoursesLoaded
                    ? courseState.courses
                    : <CourseModel>[];
                final filtered = _filterCourses(allCourses, categories);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context, filtered.length),
                    _buildSearchAndFilter(),
                    _buildCategoryChips(),
                    Expanded(
                      child: _buildCourseList(context, courseState, filtered),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int count) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
      child: Row(
        children: [
          Text('All Courses', style: AppTextStyles.h3),
          const Spacer(),
          Text(
            '$count courses',
            style: AppTextStyles.bodyMd.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 0),
      child: Row(
        children: [
          Expanded(
            child: SearchField(
              controller: _searchController,
              hintText: 'Search courses...',
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(Icons.tune_rounded, color: Colors.white, size: 22.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategoryFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is CategoryLoading || state is CategoryInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CategoryFailure) {
          return const SizedBox();
        }
        if (state is CategoryLoaded) {
          return SizedBox(
            height: 44.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
              itemCount: state.categories.length + 1,
              separatorBuilder: (_, __) => SizedBox(width: 8.w),
              itemBuilder: (_, i) {
                if (i == 0) {
                  return CategoryChip(
                    label: 'All',
                    isSelected: _selectedCategoryIndex == -1,
                    onTap: () => setState(() => _selectedCategoryIndex = -1),
                  );
                }
                return CategoryChip(
                  label: state.categories[i - 1].title,
                  isSelected: _selectedCategoryIndex == i - 1,
                  onTap: () => setState(() => _selectedCategoryIndex = i - 1),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildCourseList(
    BuildContext context,
    CoursesState courseState,
    List<CourseModel> courses,
  ) {
    if (courseState is CoursesLoading || courseState is CoursesInitial) {
      return const Center(child: CircularProgressIndicator());
    }
    if (courseState is CoursesFailure) {
      return Center(child: Text(courseState.message));
    }

    if (courses.isEmpty) {
      return EmptyState(
        emoji: '🔍',
        title: 'No courses found',
        subtitle: 'Try different keywords or reset filters',
        buttonLabel: 'Reset Filters',
        onButtonTap: () => setState(() {
          _selectedCategoryIndex = -1;
          _selectedLevel = 'All';
          _searchQuery = '';
          _searchController.clear();
        }),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 90.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 0.59,
      ),
      itemCount: courses.length,
      itemBuilder: (_, i) => CourseCard(
        course: courses[i],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CourseDetailScreen(course: courses[i]),
          ),
        ),
      ),
    );
  }
}
