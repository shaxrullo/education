import 'package:education/Bloc/CourseProgress/bloc/courseprogress_bloc.dart';
import 'package:education/Model/lessonModel.dart';
import 'package:education/app/theme/app_colors.dart';
import 'package:education/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonTile extends StatelessWidget {
  final LessonModel lesson;
  final int index;
  final VoidCallback? onTap;

  const LessonTile({
    super.key,
    required this.lesson,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BlocBuilder<CourseprogressBloc, CourseprogressState>(
        builder: (context, state) {
          bool isComplete = false;

          if (state is CourseprogresssLoaded) {
            try {
              // 1-tuzatish: "state.lessons" emas, "state.progress.lessonProgress"
              // - chunki javob endi bitta obyekt, ichida ro'yxat
              final progressItem = state.lessons.lessonProgress;
              // 2-tuzatish: "progressItem.lessonProgress.iCompleted" emas,
              // to'g'ridan-to'g'ri "progressItem.isCompleted"
              isComplete = progressItem[index].isCompleted;
            } catch (_) {
              isComplete = false;
            }
          }

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            margin: EdgeInsets.only(bottom: 8.h),
            decoration: BoxDecoration(
              color: isComplete ? AppColors.successLight : AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isComplete
                    ? AppColors.success.withValues(alpha: 0.3)
                    : AppColors.border,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: isComplete
                        ? AppColors.success
                        : AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: isComplete
                        ? Icon(
                            Icons.check_rounded,
                            color: AppColors.white,
                            size: 18.sp,
                          )
                        : Icon(
                            Icons.play_arrow_rounded,
                            color: AppColors.primary,
                            size: 18.sp,
                          ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: AppTextStyles.bodyMdSemi.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 12.sp,
                            color: AppColors.gray400,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "${lesson.duration} min",
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
