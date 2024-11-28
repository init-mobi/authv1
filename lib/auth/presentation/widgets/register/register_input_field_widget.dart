import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterInputFieldWidget extends StatefulWidget {
  const RegisterInputFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.obscure = false,
    this.inputFormatters = const [],
    this.keyboardType = TextInputType.text,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final bool obscure;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;

  @override
  _RegisterInputFieldWidgetState createState() => _RegisterInputFieldWidgetState();
}

class _RegisterInputFieldWidgetState extends State<RegisterInputFieldWidget> with SingleTickerProviderStateMixin {
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
      child: TextFormField(
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
          labelText: widget.label,
          labelStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
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
              color: const Color(0xFFff1415).withOpacity(0.7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(0),
          ),
          filled: true,
          fillColor: const Color(0xFFf6f6f8),
        ),
      ),
    );
  }
}
