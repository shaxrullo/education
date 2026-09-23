import 'package:education/app/theme/app_colors.dart';
import 'package:education/app/theme/app_text_styles.dart';
import 'package:education/data/mock_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressCard extends StatelessWidget {
  final EnrollmentModel enrollment;
  final VoidCallback? onContinue;

  const ProgressCard({super.key, required this.enrollment, this.onContinue});

  @override
  Widget build(BuildContext context) {
    final pct = (enrollment.progress * 100).round();
    final isCompleted = enrollment.isCompleted;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(16.r)),
            child: _buildImagePlaceholder(),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    enrollment.course.title,
                    style: AppTextStyles.bodyMdSemi,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    isCompleted
                        ? 'Completed'
                        : 'Next: ${enrollment.currentLesson}',
                    style: AppTextStyles.caption.copyWith(
                      color: isCompleted
                          ? AppColors.success
                          : AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.h),
                  // Progress bar
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: LinearProgressIndicator(
                            value: enrollment.progress,
                            backgroundColor: AppColors.gray100,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isCompleted
                                  ? AppColors.success
                                  : AppColors.primary,
                            ),
                            minHeight: 6.h,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '$pct%',
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isCompleted
                              ? AppColors.success
                              : AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: onContinue,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 7.h,
                      ),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppColors.successLight
                            : AppColors.primarySurface,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isCompleted
                                ? Icons.workspace_premium_rounded
                                : Icons.play_arrow_rounded,
                            color: isCompleted
                                ? AppColors.success
                                : AppColors.primary,
                            size: 14.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            isCompleted ? 'View Certificate' : 'Continue',
                            style: AppTextStyles.bodySmSemi.copyWith(
                              color: isCompleted
                                  ? AppColors.success
                                  : AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    final category = enrollment.course.category;
    final map = {
      'Programming': [AppColors.primary, AppColors.primaryDark],
      'Design': [const Color(0xFFEC4899), const Color(0xFFDB2777)],
      'Business': [const Color(0xFFF59E0B), const Color(0xFFD97706)],
      'English': [AppColors.success, const Color(0xFF059669)],
      'Mathematics': [AppColors.accent, const Color(0xFF0891B2)],
      'Marketing': [AppColors.error, const Color(0xFFDC2626)],
    };
    final colors = map[category] ?? [AppColors.primary, AppColors.primaryDark];

    return Container(
      width: 100.w,
      height: 120.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          _categoryEmoji(category),
          style: TextStyle(fontSize: 28.sp),
        ),
      ),
    );
  }

  String _categoryEmoji(String category) {
    const map = {
      'Programming': '💻',
      'Design': '🎨',
      'Business': '📊',
      'English': '🌍',
      'Mathematics': '📐',
      'Marketing': '📣',
    };
    return map[category] ?? '📚';
  }
}
