import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../themes.dart';
import './home_screen.dart';
import './sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const String routeName = 'sign-in-screen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  late String email, password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _form,
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                brandingWidget,
                const Spacer(flex: 2),
                Text('Welcome back.',
                    style:
                        MyThemes.headlineLarge.copyWith(color: Colors.white70)),
                // const SizedBox(height: 20),
                const Spacer(flex: 1),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'email can\'t be empty';
                    }
                    return null;
                  },
                  controller: _emailController,
                  onChanged: (value) => email = value,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.grey,
                        size: 25,
                      )),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: Colors.grey,
                        size: 25,
                      )),
                  controller: _passwordController,
                  onChanged: (value) => password = value,
                  validator: (value) =>
                      value!.isEmpty ? "enter your password" : null,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_form.currentState!.validate()) {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email.trim(), password: password.trim());
                            print('success');
                            setState(() {
                              showSpinner = false;
                            });
                            Navigator.pushReplacementNamed(
                                context, HomeScreen.routeName);
                          } catch (e) {
                            var err = e as FirebaseException;
                            toastMessage(e.message.toString());
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        }
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 16),
                      )),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontWeight: FontWeight.w200),
                    ),
                    TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, SignUpScreen.routeName),
                        child: const Text('Sign up'))
                  ],
                ),
                const Spacer(flex: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
