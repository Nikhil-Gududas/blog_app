import 'package:blog_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import 'sign_in_screen.dart';
import '../themes.dart';

import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);
  static const routeName = "sign-up-screen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late String email, password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                brandingWidget,
                const Spacer(flex: 2),
                Text('Join, to Blog',
                    style:
                        MyThemes.headlineLarge.copyWith(color: Colors.white70)),
                // const SizedBox(height: 20),
                const Spacer(flex: 1),
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => email = value,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'email can\'t be empty';
                    }
                    return null;
                  },
                  style: const TextStyle(
                    fontSize: 16,
                  ),
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
                  controller: _password,
                  onChanged: (value) => password = value,
                  obscureText: true,
                  style: const TextStyle(fontSize: 16),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Password can\'t be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: Colors.grey,
                        size: 25,
                      )),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Password can\'t be empty';
                    } else if (text != password) {
                      return 'password should be same';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: Colors.grey,
                        size: 25,
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final user =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email.trim(),
                                    password: password.trim());
                            print('success');
                            print(user);
                            toastMessage('logged in');
                            setState(() {
                              showSpinner = false;
                            });
                            Navigator.pushReplacementNamed(
                                context, HomeScreen.routeName);
                          } catch (e) {
                            print(e);
                            toastMessage(e.toString());
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        }
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 16),
                      )),
                ),
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                  TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, SignInScreen.routeName),
                      child: const Text('Sign in'))
                ]),
                const Spacer(flex: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
