import 'package:flutter/material.dart';

class LoginPassWidget extends StatelessWidget {
  const LoginPassWidget({super.key});

  final rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: (value) => (),
            ),
            const Text('Запомнить меня'),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Забыл пароль'),
        ),
      ],
    );
  }
}
