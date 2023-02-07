import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.textEditingController,
  });
  final TextEditingController textEditingController;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: const Icon(
            Icons.lock_rounded,
            color: Colors.grey,
            size: 25,
          ),
          suffixIcon: GestureDetector(
            onTap: () => setState(() {
              obscureText = !obscureText;
            }),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                obscureText
                    ? 'assets/icons/view.png'
                    : 'assets/icons/hidden.png',
                color: Colors.grey,
                height: 10,
                width: 10,
                scale: 0.7,
              ),
            ),
          )),
      controller: widget.textEditingController,
      validator: (value) => value!.isEmpty ? "enter your password" : null,
    );
  }
}
