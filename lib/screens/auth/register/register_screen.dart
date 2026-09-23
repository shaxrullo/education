import 'package:education/Bloc/Register/register_bloc.dart';
import 'package:education/app/theme/app_colors.dart';
import 'package:education/app/theme/app_text_styles.dart';
import 'package:education/screens/auth/login/login_screen.dart';
import 'package:education/widgets/custom_text_field.dart';
import 'package:education/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  final formKey = GlobalKey<FormState>();

  String? selectedRole;

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _firstnameController.dispose();
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
                SizedBox(height: 24.h),
                // Back
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
                SizedBox(height: 24.h),
                Text('Create Account ✨', style: AppTextStyles.h2),
                SizedBox(height: 6.h),
                Text(
                  'Join thousands of learners worldwide',
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 32.h),
                // Name
                CustomTextField(
                  label: ' Name',
                  hintText: 'Enter your name',
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                    size: 20.sp,
                    color: AppColors.gray400,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Ism bosh bolishi mumkin emas";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.h),
                // Name
                CustomTextField(
                  label: 'First Name',
                  hintText: 'Enter your first name',
                  controller: _firstnameController,
                  keyboardType: TextInputType.name,
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                    size: 20.sp,
                    color: AppColors.gray400,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Familyaingiz bosh bolishi mumkin emas";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 32.h),
                // Name
                CustomTextField(
                  label: 'Username',
                  hintText: 'Enter your first name',
                  controller: _usernameController,
                  keyboardType: TextInputType.name,
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                    size: 20.sp,
                    color: AppColors.gray400,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Username bosh bolishi mumkin emas";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.h),
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
                // Phone
                CustomTextField(
                  label: 'Phone Number',
                  hintText: '+998 90 123 45 67',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                    size: 20.sp,
                    color: AppColors.gray400,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Telefon raqam kiritng";
                    }
                    if (value.length > 13 || value.length < 13) {
                      return "Telefon raqamingizni togri kiritng";
                    }
                    if (value.startsWith("+998", 0) == false) {
                      return "Ozbekiston kodi bilan boshlansin nomeringing +998";
                    }
                    if (RegExp(r'[a-zA-Z]').hasMatch(value)) {
                      return "Telefon raqamda harf bolishi mumkin emas";
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
                SizedBox(height: 16.h),
                // Confirm Password
                CustomTextField(
                  label: 'Confirm Password',
                  hintText: 'Repeat your password',
                  controller: _confirmController,
                  obscureText: _obscureConfirm,
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    size: 20.sp,
                    color: AppColors.gray400,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                    child: Icon(
                      _obscureConfirm
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20.sp,
                      color: AppColors.gray400,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Parolni tasdiqlang";
                    }

                    if (value != _passwordController.text) {
                      return "Parollar bir xil emas";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 32.h),
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  decoration: InputDecoration(
                    hintText: "Rolni tanlang",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: "student", child: Text("O'quvchi")),
                    DropdownMenuItem(
                      value: "teacher",
                      child: Text("O'qituvchi"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Rolni tanlang";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.h),
                // TODO: Connect BLoC register event here
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Muvaffaqiyatli ro'yxatdan o'tdingiz"),
                        ),
                      );
                    } else if (state is RegisterFailure) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is RegisterLoading;
                    return PrimaryButton(
                      text: 'Create Account',
                      onTap: isLoading
                          ? null
                          : () {
                              if (!formKey.currentState!.validate()) return;
                              context.read<RegisterBloc>().add(
                                RegisterRequested(
                                  email: _emailController.text.trim(),
                                  username: _usernameController.text.trim(),
                                  firstName: _firstnameController.text.trim(),
                                  last_name: _nameController.text.trim(),
                                  phone: _phoneController.text.trim(),
                                  password: _passwordController.text,
                                  password2: _confirmController.text,
                                  role:
                                      selectedRole!, // sizda qanday saqlangan bo'lsa
                                ),
                              );
                            },
                    );
                  },
                ),
                SizedBox(height: 24.h),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: AppTextStyles.bodyMd.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'Sign In',
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
