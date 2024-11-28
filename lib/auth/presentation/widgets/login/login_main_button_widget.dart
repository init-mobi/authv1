import 'package:flutter/material.dart';

class LoginMainButtonWidget extends StatelessWidget {
  const LoginMainButtonWidget({super.key, this.isLoading = false, required this.onAsyncAction});

  final Future<void> Function() onAsyncAction;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : () async {
                try {
                  await onAsyncAction();
                } catch (e) {
                  print('button onAsyncAction(): $e');
                }
              },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isLoading ? Colors.grey[400] : const Color(0xFFff1415),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Зарегистрироваться',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Gilroy',
                ),
              ),
      ),
    );
  }
}
