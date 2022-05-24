import 'package:flutter/material.dart';
import 'package:pre_proyecto_universales_chat/Localization/localization.dart';
import 'package:pre_proyecto_universales_chat/Providers/languaje_provider.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_strings.dart';
import 'package:provider/provider.dart';

class TopHeaderSignUp extends StatelessWidget {
  const TopHeaderSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguajeProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);

    return Padding(
        padding: const EdgeInsets.only(left: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${localization.dictionary(Strings.registerText)}\n  UniChat',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                  fontFamily: 'Quicksand',
                  letterSpacing: 2),
            ),
            const Image(
              image: AssetImage('assets/garantia.png'),
              height: 170,
              fit: BoxFit.fitHeight,
            ),
          ],
        ));
  }
}