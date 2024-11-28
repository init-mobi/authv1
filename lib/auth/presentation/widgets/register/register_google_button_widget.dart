import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterGoogleButtonWidget extends StatelessWidget {
  const RegisterGoogleButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.9,
      child: ElevatedButton(
        onPressed: () {
          // AuthService().signInWithGoogle(context);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: const Color(0xFFFAFDFF),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/google-icon.svg',
                height: 20,
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                'Войти с Google',
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
