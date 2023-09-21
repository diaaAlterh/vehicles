import 'package:flutter/material.dart';

class AuthQuestion extends StatelessWidget {
  final String question;
  final String button;
  final Function() onPressed;

  const AuthQuestion(
      {super.key,
      required this.question,
      required this.button,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        TextButton(
            onPressed: onPressed,
            child: Text(
              button,
            ))
      ],
    );
  }
}
