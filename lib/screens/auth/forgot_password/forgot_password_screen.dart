import 'package:education/app/theme/app_colors.dart';
import 'package:education/app/theme/app_text_styles.dart';
import 'package:education/screens/auth/otp/otp_screen.dart';
import 'package:education/widgets/custom_text_field.dart';
import 'package:education/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              // Illustration
              Center(
                child: Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_reset_rounded,
                    color: AppColors.primary,
                    size: 48.sp,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Text('Forgot Password?', style: AppTextStyles.h2),
              SizedBox(height: 8.h),
              Text(
                'No worries! Enter your email and we\'ll send you a reset link.',
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 32.h),
              CustomTextField(
                label: 'Email Address',
                hintText: 'Enter your registered email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  size: 20.sp,
                  color: AppColors.gray400,
                ),
              ),
              SizedBox(height: 28.h),
              // TODO: Connect BLoC forgot password event here
              PrimaryButton(
                text: 'Send Reset Code',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OtpScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
