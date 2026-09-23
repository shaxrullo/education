import 'package:education/Bloc/Login/login_bloc.dart';
import 'package:education/app/theme/app_colors.dart';
import 'package:education/app/theme/app_text_styles.dart';
import 'package:education/screens/auth/register/register_screen.dart';
import 'package:education/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:education/screens/main/main_screen.dart';
import 'package:education/widgets/custom_text_field.dart';
import 'package:education/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                // Logo
                Center(
                  child: Container(
                    width: 72.w,
                    height: 72.h,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.school_rounded,
                      color: Colors.white,
                      size: 36.sp,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                Text('Welcome back 👋', style: AppTextStyles.h2),
                SizedBox(height: 6.h),
                Text(
                  'Sign in to continue your learning journey',
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 36.h),
                // Email
                CustomTextField(
                  label: 'Email',
                  hintText: 'Enter your email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 20.sp,
                    color: AppColors.gray400,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Emailingizni kiriting";
                    }
                    if (!RegExp(
                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                    ).hasMatch(value)) {
                      return "To'g'ri email kiritng";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                // Password
                CustomTextField(
                  label: 'Password',
                  hintText: 'Create a password',
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    size: 20.sp,
                    color: AppColors.gray400,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20.sp,
                      color: AppColors.gray400,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Parol kiriting";
                    }
                    if (value.length < 8) {
                      return "Parol kamida 8 ta belgidan iborat bo'lishi kerak";
                    }
                    if (!RegExp(r'[A-Z]').hasMatch(value)) {
                      return "Parolda kamida bitta katta harf bo'lsin";
                    }
                    if (!RegExp(r'[a-z]').hasMatch(value)) {
                      return "Parolda kamida bitta kichik harf bo'lsin";
                    }
                    if (!RegExp(r'[0-9]').hasMatch(value)) {
                      return "Parolda kamida bitta raqam bo'lsin";
                    }
                    if (!RegExp(
                      r'[!@#\$%^&*(),.?":{}|<>_\-]',
                    ).hasMatch(value)) {
                      return "Parolda kamida bitta maxsus belgi bo'lsin (masalan !@#\$%)";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12.h),
                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ForgotPasswordScreen(),
                      ),
                    ),
                    child: Text(
                      'Forgot password?',
                      style: AppTextStyles.bodyMdSemi.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 28.h),
                // Login button
                // TODO: Connect BLoC login event here
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Xush kelibsiz")),
                      );
                    } else if (state is LoginFailure) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is LoginLoading;
                    return PrimaryButton(
                      text: 'Sign In',
                      onTap: isLoading
                          ? null
                          : () {
                              if (!formKey.currentState!.validate()) return;
                              context.read<LoginBloc>().add(
                                LoginRequested(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text,
                                ),
                              );
                            },
                    );
                  },
                ),
                SizedBox(height: 24.h),
                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.border)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        'or continue with',
                        style: AppTextStyles.caption,
                      ),
                    ),
                    const Expanded(child: Divider(color: AppColors.border)),
                  ],
                ),
                SizedBox(height: 20.h),
                // Social buttons
                Row(
                  children: [
                    Expanded(
                      child: _SocialButton(
                        icon: Icons.g_mobiledata_rounded,
                        label: 'Google',
                        iconColor: const Color(0xFFEA4335),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _SocialButton(
                        icon: Icons.facebook_rounded,
                        label: 'Facebook',
                        iconColor: const Color(0xFF1877F2),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                // Register
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: AppTextStyles.bodyMd.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterScreen(),
                          ),
                        ),
                        child: Text(
                          'Sign Up',
                          style: AppTextStyles.bodyMdSemi.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 24.sp),
          SizedBox(width: 8.w),
          Text(label, style: AppTextStyles.bodyMdSemi),
        ],
      ),
    );
  }
}
