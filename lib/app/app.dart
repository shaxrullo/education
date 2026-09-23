import 'package:education/app/splashScreen.dart';
import 'package:education/app/theme/app_theme.dart';
import 'package:education/screens/auth/login/login_screen.dart';
import 'package:flutter/material.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learnzilla',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LoginScreen(),
    );
  }
}
