import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:messenger/features/auth/presentation/screens/register_screen.dart';

class LoginSubtitleWidget extends StatelessWidget {
  const LoginSubtitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Если у вас еще нет аккаунта - ',
            style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 15, fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: 'зарегистрируйтесь',
            style: const TextStyle(color: Color(0xFFff1415), fontSize: 15),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
          ),
        ],
      ),
    );
  }
}
