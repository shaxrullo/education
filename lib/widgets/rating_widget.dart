import 'package:education/app/theme/app_colors.dart';
import 'package:education/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final int? reviewCount;
  final double iconSize;
  final bool showCount;

  const RatingWidget({
    super.key,
    required this.rating,
    this.reviewCount,
    this.iconSize = 14,
    this.showCount = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: AppColors.star, size: iconSize.sp),
        SizedBox(width: 3.w),
        Text(
          rating.toStringAsFixed(1),
          style: AppTextStyles.bodySmSemi.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        if (showCount && reviewCount != null) ...[
          SizedBox(width: 3.w),
          Text('(${_formatCount(reviewCount!)})', style: AppTextStyles.caption),
        ],
      ],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}
