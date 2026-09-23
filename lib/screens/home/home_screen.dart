import 'package:education/Bloc/Category/category_bloc.dart';
import 'package:education/Bloc/Courses/courses_bloc.dart';
import 'package:education/Services/apikeys.dart';
import 'package:education/app/theme/app_colors.dart';
import 'package:education/app/theme/app_text_styles.dart';
import 'package:education/data/mock_data.dart';
import 'package:education/screens/course_detail/course_detail_screen.dart';
import 'package:education/screens/search/search_screen.dart';
import 'package:education/widgets/category_card.dart';
import 'package:education/widgets/course_card.dart';
import 'package:education/widgets/progress_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CategoryBloc>().add(CategoryRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            SliverToBoxAdapter(child: _buildSearchBar(context)),
            SliverToBoxAdapter(child: SizedBox(height: 24.h)),
            SliverToBoxAdapter(child: SizedBox(height: 24.h)),
            SliverToBoxAdapter(
              child: _buildSectionHeader('Categories', context),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 14.h)),
            SliverToBoxAdapter(child: _buildCategories()),
            SliverToBoxAdapter(child: SizedBox(height: 24.h)),
            SliverToBoxAdapter(
              child: _buildSectionHeader('Main Courses', context),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 14.h)),
            SliverToBoxAdapter(child: _buildPopularCourses(context)),
            SliverToBoxAdapter(child: SizedBox(height: 24.h)),
            SliverToBoxAdapter(
              child: _buildSectionHeader('Continue Learning', context),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 14.h)),
            SliverToBoxAdapter(child: _buildContinueLearning(context)),
            SliverToBoxAdapter(child: SizedBox(height: 90.h)),
          ],
        ),
      ),
    );
  }

  //Appbar qismi
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assalomu Alaykum',
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                apiService.currentUser?.lastName ?? '',
                style: AppTextStyles.h3,
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                apiService.currentUser?.lastName[0].toUpperCase()??'?',
                style: AppTextStyles.h4.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Search
  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BlocConsumer<CoursesBloc, CoursesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if(state is CoursesLoaded){
          return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SearchScreen(coursesList: state.courses,)),
              ),
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(width: 14.w),
                    Icon(Icons.search_rounded, color: AppColors.gray400, size: 20.sp),
                    SizedBox(width: 10.w),
                    Text(
                      'What do you want to learn?',
                      style: AppTextStyles.bodyMd.copyWith(color: AppColors.textHint),
                    ),
                    const Spacer(),
                    Container(
                      margin: EdgeInsets.all(6.w),
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: AppColors.primarySurface,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.tune_rounded,
                        color: AppColors.primary,
                        size: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  //hammasini usti
  Widget _buildSectionHeader(String title, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Text(title, style: AppTextStyles.h4),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Text(
              'See all',
              style: AppTextStyles.bodySmSemi.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Category
  Widget _buildCategories() {
    return SizedBox(
      height: 101.h,
      child: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategoryFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is CategoryLoading || state is CategoryInitial) {
            return CircularProgressIndicator();
          }
          if (state is CategoryFailure) {
            return const SizedBox(); // xato SnackBar orqali ko'rsatiladi, bu yerda bo'sh qoldiriladi
          }
          if (state is CategoryLoaded) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CategoryCard(category: state.categories[index]);
              },
              separatorBuilder: (context, index) => SizedBox(height: 12),
              itemCount: state.categories.length,
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget _buildPopularCourses(BuildContext context) {
    return BlocConsumer<CoursesBloc, CoursesState>(
      listener: (context, state) {
        if (state is CoursesFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is CategoryLoading || state is CategoryInitial) {
          return CircularProgressIndicator();
        }
        if (state is CategoryFailure) {
          return const SizedBox();
        }
        if (state is CoursesLoaded) {
          return SizedBox(
            height: 230.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: state.courses.length,
              separatorBuilder: (_, __) => SizedBox(width: 16.w),
              itemBuilder: (_, i) => CourseCardHorizontal(
                course: state.courses[i],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CourseDetailScreen(course: state.courses[i]),
                  ),
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildContinueLearning(BuildContext context) {
    final inProgress = mockEnrollments.where((e) => !e.isCompleted).toList();
    if (inProgress.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          height: 100.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Center(
            child: Text(
              'No courses in progress',
              style: AppTextStyles.bodyMd.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: inProgress
            .take(2)
            .map(
              (e) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: ProgressCard(enrollment: e, onContinue: () {}),
              ),
            )
            .toList(),
      ),
    );
  }
}
