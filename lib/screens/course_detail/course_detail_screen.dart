import 'package:education/Bloc/Complete/bloc/complete_bloc.dart';
import 'package:education/Bloc/CourseProgress/bloc/courseprogress_bloc.dart';
import 'package:education/Bloc/Lesson/bloc/lesson_bloc.dart';
import 'package:education/Model/CoursesModel.dart';
import 'package:education/Model/completeModel.dart';
import 'package:education/app/theme/app_colors.dart';
import 'package:education/app/theme/app_text_styles.dart';
import 'package:education/screens/QuizTest/quiztest.dart';
import 'package:education/screens/lesson/lesson_screen.dart';
import 'package:education/widgets/lesson_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseDetailScreen extends StatefulWidget {
  final CourseModel course;
  const CourseDetailScreen({super.key, required this.course});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  final List<Completemodel> complete = [];
  bool _checkIfCompleted(CompleteState state, int lessonId) {
    if (state is CompleteLoaded) {
      try {
        // ID larni String ga o'tkazib solishtiramiz (1 va "1" chalkashmasligi uchun)
        final item = state.complete.firstWhere(
          (c) => c.lesson.toString() == lessonId.toString(),
        );
        return item.isCompleted;
      } catch (_) {
        return false;
      }
    }
    return false;
  }

  @override
  void initState() {
    context.read<LessonBloc>().add(LessonRequested(lessonId: widget.course.id));
    context.read<CourseprogressBloc>().add(
      CourseProgressRequested(courseId: widget.course.id),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildSliverHeader(course, context),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      _buildCategory(course),
                      SizedBox(height: 10.h),
                      Text(course.title, style: AppTextStyles.h3),
                      SizedBox(height: 12.h),
                      _buildStats(course),
                      SizedBox(height: 16.h),
                      _buildTeacherRow(course),
                      SizedBox(height: 20.h),
                      const Divider(color: AppColors.divider),
                      SizedBox(height: 16.h),
                      _buildDescription(course),
                      SizedBox(height: 20.h),
                      _buildCurriculum(course, context),
                      SizedBox(height: 20.h),
                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Bottom bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomBar(context, course),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverHeader(CourseModel course, BuildContext context) {
    return SliverAppBar(
      expandedHeight: 240.h,
      pinned: true,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.white),
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18.sp,
            color: AppColors.white,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: course.image != null
            ? Image.network(course.image!, fit: BoxFit.cover)
            : Container(
                color: AppColors.gray200,
                child: const Icon(Icons.image_not_supported, size: 40),
              ),
      ),
    );
  }

  Widget _buildCategory(CourseModel course) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        course.category.title, //categorylar ni sozlayman keyin
        style: AppTextStyles.caption.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildStats(CourseModel course) {
    return Wrap(
      spacing: 16.w,
      runSpacing: 8.h,
      children: [
        _StatChip(
          icon: Icons.access_time_rounded,
          label: course.duration.toString(),
        ),
        _StatChip(
          icon: Icons.play_circle_outline_rounded,
          label: '${course.lessonCount} lessons',
        ),
        _StatChip(
          icon: Icons.bar_chart_rounded,
          label: course.level.toString(),
        ),
      ],
    );
  }

  Widget _buildTeacherRow(CourseModel course) {
    return Row(
      children: [
        Container(
          width: 42.w,
          height: 42.h,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Text(
              course.teacher.name[0],
              style: AppTextStyles.h4.copyWith(color: Colors.white),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${course.teacher.name} ${course.teacher.lastName}",
              style: AppTextStyles.bodyMdSemi,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription(CourseModel course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About this course', style: AppTextStyles.h4),
        SizedBox(height: 10.h),
        Text(
          course.shortDescription.toString(),
          style: AppTextStyles.bodyMd.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildCurriculum(CourseModel course, BuildContext context) {
    return BlocBuilder<LessonBloc, LessonState>(
      builder: (context, lessonState) {
        if (lessonState is LessonLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (lessonState is LessonFailure) {
          return Text(lessonState.message);
        }
        if (lessonState is LessonLoaded) {
          final lessons = lessonState.lessons;

          // CompleteBloc-ni darslar ro'yxati ustidan bir marta o'raymiz
          return BlocBuilder<CompleteBloc, CompleteState>(
            builder: (context, completeState) {
              return Column(
                children: lessons.asMap().entries.map((e) {
                  final index = e.key;
                  final lesson = e.value;

                  // HAR BIR DARS UCHUN O'ZINING statusini olamiz:
                  final bool isLessonCompleted = _checkIfCompleted(
                    completeState,
                    lesson.id!,
                  );

                  return LessonTile(
                    key: ValueKey(lesson.id),
                    lesson: lesson,
                    index: index + 1,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LessonScreen(
                            courseId: widget.course.id,
                            lesson: lesson,
                            courseTitle: course.title,
                            isComplete: isLessonCompleted,
                          ),
                        ),
                      ).then((_) {
                        // LessonScreen'dan orqaga qaytganda CompleteBloc va LessonBloc-ni qayta yangilaymiz!
                        if (context.mounted) {
                          context.read<CompleteBloc>().add(
                            CompleteRequest(lessonId: lesson.id!),
                          );
                        }
                      });
                    },
                  );
                }).toList(),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildBottomBar(BuildContext context, CourseModel course) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Quiztest(courseId: course.id, title: course.title),
        ),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: 12.w),
            GestureDetector(
              child: Container(
                height: 52.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.quiz_outlined,
                      color: AppColors.primary,
                      size: 20.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Test',
                      style: AppTextStyles.bodyMdSemi.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.sp, color: AppColors.gray400),
        SizedBox(width: 4.w),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}
