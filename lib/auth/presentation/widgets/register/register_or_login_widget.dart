import 'package:flutter/material.dart';

class RegisterOrLoginWidget extends StatelessWidget {
  const RegisterOrLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Divider(),
        Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.1,
                decoration: const BoxDecoration(color: Colors.white),
                child: Center(
                  child: Text(
                    'или',
                    style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.5), fontSize: 16),
                  ),
                )))
      ],
    );
  }
}
