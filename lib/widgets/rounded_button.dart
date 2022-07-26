import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key, required this.text, required this.onTap, required this.icon})
      : super(key: key);
  final VoidCallback onTap;
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.black)),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: SizedBox(height: 24, width: 24, child: icon)),
                Expanded(
                  flex: 8,
                  child: Center(
                    child: Text(
                      text,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Expanded(flex: 1, child: Container())
              ],
            )));
  }
}
