import 'package:flutter/material.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_colors.dart';
import 'package:pre_proyecto_universales_chat/Widgets/style.dart';

class InputPassword extends StatefulWidget {
  String hintText;
  IconData icon;
  TextEditingController controller;
  String? Function(String?)? validator;
  Iterable<String>? autofillHints;

  InputPassword(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.controller,
      this.validator,
      this.autofillHints})
      : super(key: key);

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _passwordInvisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: _passwordInvisible,
        controller: widget.controller,
        validator: widget.validator,
        autofillHints: widget.autofillHints,
        style: const TextStyle(
            fontFamily: 'Quicksand', fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : cyprus2,
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
          enabledBorder: getInputBorderStyle(context),
          focusedBorder: getInputBorderStyle(context),
          focusedErrorBorder: getInputBorderStyle(context),
          errorBorder: getInputBorderStyle(context),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black54
                  : Colors.white60,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.normal),
          errorStyle: const TextStyle(fontSize: 11.0, fontFamily: 'Quicksand'),
        ),
      ),
    );
  }
}
