import 'package:flutter/material.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_colors.dart';

class LabelText extends StatelessWidget {
  String label;
  LabelText({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 0.75,
          fontFamily: 'Quicksand',
          color: Theme.of(context).brightness == Brightness.light
              ? cyprus
              : cultured,
          fontSize: 16,
        ),
      ),
    );
  }
}
