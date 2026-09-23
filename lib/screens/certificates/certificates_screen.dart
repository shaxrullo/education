import 'package:education/app/theme/app_colors.dart';
import 'package:education/data/mock_data.dart';
import 'package:education/widgets/certificate_card.dart';
import 'package:education/widgets/custom_app_bar.dart';
import 'package:education/widgets/empty_error_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'My Certificates'),
      body: mockCertificates.isEmpty
          ? const EmptyState(
              emoji: '🏆',
              title: 'No certificates yet',
              subtitle: 'Complete a course to earn your first certificate',
            )
          : ListView.separated(
              padding: EdgeInsets.all(20.w),
              itemCount: mockCertificates.length,
              separatorBuilder: (_, _) => SizedBox(height: 16.h),
              itemBuilder: (_, i) => CertificateCard(
                certificate: mockCertificates[i],
                onView: () {},
              ),
            ),
    );
  }
}
