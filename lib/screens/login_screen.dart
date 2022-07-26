import 'package:flutter/material.dart';

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
          InkWell(
              onTap: () {},
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black)),
                  alignment: Alignment.center,
                  child: const Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 18),
                  ))),
          const SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () {},
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black)),
                  alignment: Alignment.center,
                  child: const Text(
                    'Sign in with Email',
                    style: TextStyle(fontSize: 18),
                  ))),
          const SizedBox(
            height: 25,
          ),
          const Text('or Sign in with'),
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
