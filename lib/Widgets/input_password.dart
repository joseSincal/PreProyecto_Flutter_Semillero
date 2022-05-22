import 'package:flutter/material.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_colors.dart';

class InputPassword extends StatefulWidget {
  String hintText;
  IconData icon;

  InputPassword({Key? key, required this.hintText, required this.icon})
      : super(key: key);

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _passwordInvisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.fromLTRB(16, 3, 16, 6),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : cyprus2,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.light
              ? salem
              : cultured,
        ),
      ),
      child: Center(
        child: TextField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: _passwordInvisible,
          decoration: InputDecoration(
              prefixIcon: Icon(widget.icon,
                  color: Theme.of(context).brightness == Brightness.light
                      ? salem
                      : cultured),
              suffixIcon: IconButton(
                icon: Icon(
                    _passwordInvisible
                        ? Icons.lock_outline_rounded
                        : Icons.lock_open_rounded,
                    color: Theme.of(context).brightness == Brightness.light
                        ? salem.withAlpha(150)
                        : cultured.withAlpha(150)),
                onPressed: () {
                  setState(() {
                    _passwordInvisible = !_passwordInvisible;
                  });
                },
              ),
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black54
                      : Colors.white60,
                  fontFamily: 'Quicksand')),
        ),
      ),
    );
  }
}
