import 'package:blog_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    'assets/images/logo.png',
                  )),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "Blog App",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ],
          ),
          const SizedBox(height: 60),
          const Text('Welcome back.', style: TextStyle(fontSize: 45)),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RoundedButton(
                text: 'Sign in with Google',
                onTap: () {},
                icon: SvgPicture.asset('assets/icons/google.svg')),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RoundedButton(
                text: 'Sign in with Google',
                onTap: () {},
                icon: Icon(Icons.email_outlined)),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 05),
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                const Text('or, Sign in with'),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 05, right: 20),
                    color: Colors.black,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black)),
                child: Image.asset('assets/icons/facebook.png'),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black)),
                child: Image.asset('assets/icons/twitter.png'),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Don't have an account?"),
              Text(
                " Sign up",
                style: TextStyle(color: Colors.green),
              )
            ],
          )
        ],
      ),
    ));
  }
}
