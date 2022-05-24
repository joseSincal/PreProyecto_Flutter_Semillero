import 'package:flutter/material.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_colors.dart';
import 'package:pre_proyecto_universales_chat/Widgets/style.dart';

class InputText extends StatelessWidget {
  String hintText;
  IconData icon;
  TextEditingController controller;
  String? Function(String?)? validator;
  Iterable<String>? autofillHints;

  InputText(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.controller,
      this.validator,
      this.autofillHints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
        validator: validator,
        autofillHints: autofillHints,
        style: const TextStyle(
            fontFamily: 'Quicksand', fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : cyprus2,
          prefixIcon: Icon(icon,
              color: Theme.of(context).brightness == Brightness.light
                  ? salem
                  : cultured),
          enabledBorder: getInputBorderStyle(context),
          focusedBorder: getInputBorderStyle(context),
          focusedErrorBorder: getInputBorderStyle(context),
          errorBorder: getInputBorderStyle(context),
          hintText: hintText,
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
