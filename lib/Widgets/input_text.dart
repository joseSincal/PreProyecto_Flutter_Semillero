import 'package:flutter/material.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_colors.dart';

class InputText extends StatelessWidget {
  String hintText;
  IconData icon;
  TextInputType? keyboardType;

  InputText(
      {Key? key, required this.hintText, required this.icon, this.keyboardType})
      : super(key: key);

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
          keyboardType: keyboardType,
          decoration: InputDecoration(
              prefixIcon: Icon(icon,
                  color: Theme.of(context).brightness == Brightness.light
                      ? salem
                      : cultured),
              border: InputBorder.none,
              hintText: hintText,
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
