import 'package:flutter/material.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_colors.dart';

OutlineInputBorder getInputBorderStyle(BuildContext context) {
  return OutlineInputBorder(
      borderSide: BorderSide(
          color: Theme.of(context).brightness == Brightness.light
              ? salem
              : cultured),
      borderRadius: const BorderRadius.all(Radius.circular(18)));
}
