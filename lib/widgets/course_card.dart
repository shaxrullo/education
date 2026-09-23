import 'package:education/Model/CoursesModel.dart';
import 'package:education/app/theme/app_colors.dart';
import 'package:education/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Vertical course card — used in search, list, grid
class CourseCard extends StatelessWidget {
  final CourseModel course;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const CourseCard({
    super.key,
    required this.course,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  child: Image.network(
                    course.image!,
                    height: 150,
                    width: double.infinity,
                    fit: .cover,
                  ),
                ),
              ],
            ),
            // Info
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category chip
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      course.category.title,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    course.title,
                    style: AppTextStyles.bodyMdSemi,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    course.teacher.name,
                    style: AppTextStyles.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),

                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Horizontal course card — used in Home popular section
class CourseCardHorizontal extends StatelessWidget {
  final CourseModel course;
  final VoidCallback? onTap;

  const CourseCardHorizontal({super.key, required this.course, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240.w,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: Stack(
                children: [
                  Image.network(
                    course.image!,
                    width: double.infinity,
                    height: 120,
                    fit: .cover,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: AppTextStyles.bodyMdSemi,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(course.teacher.name, style: AppTextStyles.caption),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: .start,
                    children: [
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.access_time,
                        size: 13.sp,
                        color: AppColors.gray400,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        '${course.duration} soat',
                        style: AppTextStyles.caption,
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.people_outline,
                        size: 13.sp,
                        color: AppColors.gray400,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        '${course.studentCount} soni',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  Text(
                        maxLines: 1,
                    '${course.shortDescription}',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
