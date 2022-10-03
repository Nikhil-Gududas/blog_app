import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './home_screen.dart';
import './sign_up_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    final user = auth.currentUser;
    print(user);
    if (user != null) {
      Future.delayed(const Duration(milliseconds: 1500),
          () => Navigator.pushReplacementNamed(context, HomeScreen.routeName));
    } else {
      Future.delayed(
          const Duration(milliseconds: 1500),
          () =>
              Navigator.pushReplacementNamed(context, SignUpScreen.routeName));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF121212),
      child: Container(
        padding: const EdgeInsets.all(100),
        child: Image.asset(
          'assets/images/light_logo.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
