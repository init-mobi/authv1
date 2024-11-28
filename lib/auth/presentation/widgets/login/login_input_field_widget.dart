import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginInputFieldWidget extends StatefulWidget {
  const LoginInputFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.obscure = false,
    this.inputFormatters = const [],
    this.keyboardType = TextInputType.text,
    required this.title,
  });

  final String title;
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final bool obscure;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;

  @override
  _LoginInputFieldWidgetState createState() => _LoginInputFieldWidgetState();
}

class _LoginInputFieldWidgetState extends State<LoginInputFieldWidget> with SingleTickerProviderStateMixin {
  double shakeOffset = 0;
  late AnimationController _controller;
  late bool _obscureStatus;

  @override
  void initState() {
    super.initState();

    _obscureStatus = widget.obscure;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    )..addListener(() {
        setState(() {
          shakeOffset = _controller.value * 10;
        });
      });

    widget.controller.addListener(() {
      if (mounted) {
        setState(() {
          shakeOffset = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void triggerShake() {
    _controller.forward(from: 0).then((_) => _controller.reverse());
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureStatus = !_obscureStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(shakeOffset, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.w500, fontSize: 15),
            ),
            const SizedBox(
              height: 6,
            ),
            TextFormField(
              controller: widget.controller,
              obscureText: _obscureStatus,
              inputFormatters: widget.inputFormatters,
              keyboardType: widget.keyboardType,
              validator: (value) {
                final result = widget.validator?.call(value);
                if (result != null) {
                  triggerShake();
                }
                return result;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
                hintText: widget.label,
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 15),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                suffixIcon: widget.obscure
                    ? IconButton(
                        icon: Icon(
                          _obscureStatus ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: _togglePasswordVisibility,
                      )
                    : null,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xfffa4d4d).withOpacity(0.7),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xfffa4d4d).withOpacity(0.7),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xfffa4d4d).withOpacity(0.7),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(0),
                ),
                filled: true,
                fillColor: const Color(0xFFf6f6f8),
              ),
            ),
          ],
        ));
  }
}
