import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/new_blog_screen.dart';
import './screens/splash_screen.dart';
import './screens/home_screen.dart';
import './screens/sign_in_screen.dart';
import './screens/sign_up_screen.dart';
import './themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyThemes.themeData,
      routes: {
        '/': (context) => const SplashScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        SignInScreen.routeName: (context) => SignInScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        NewBlogScreen.routeName: (context) => NewBlogScreen(),
      },
      // initialRoute: SignUpScreen.routeName,
    );
  }
}
