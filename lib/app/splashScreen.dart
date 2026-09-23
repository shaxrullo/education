import 'package:education/Services/storageServises.dart';
import 'package:education/screens/auth/login/login_screen.dart';
import 'package:education/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final token = await storageService.getToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      // Token bor bo'lsa -> Asosiy sahifaga (HomeScreen)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      // Token yo'q bo'lsa -> Login sahifasiga
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
