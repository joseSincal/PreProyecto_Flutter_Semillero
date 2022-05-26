import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pre_proyecto_universales_chat/Localization/localization.dart';
import 'package:pre_proyecto_universales_chat/Models/user_model.dart';
import 'package:pre_proyecto_universales_chat/Providers/languaje_provider.dart';
import 'package:pre_proyecto_universales_chat/Providers/theme_provider.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_colors.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_strings.dart';
import 'package:pre_proyecto_universales_chat/Widgets/navigation_drawe.dart';
import 'package:provider/provider.dart';

class PageSettings extends StatelessWidget {
  static const keyLanguage = 'key-language';
  const PageSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguajeProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);

    return Scaffold(
      backgroundColor:
          Theme.of(context).brightness == Brightness.light ? cultured : cyprus2,
      appBar: AppBar(
        title: Text(
          localization.dictionary(Strings.settings),
          style: const TextStyle(
              fontFamily: 'Quicksand', fontWeight: FontWeight.w600),
        ),
        backgroundColor:
            Theme.of(context).brightness == Brightness.light ? eden : cyprus,
      ),
      drawer: const NavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, top: 55),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _titleOption(
                    context,
                    localization.dictionary(Strings.languajeOption),
                    CupertinoIcons.globe),
                _dropDownLanguaje(context)
              ],
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _titleOption(
                    context,
                    localization.dictionary(Strings.themeOption),
                    CupertinoIcons.paintbrush),
                _dropDownTheme(context)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _titleOption(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).brightness == Brightness.light
              ? cyprus
              : cultured,
        ),
        const SizedBox(width: 17),
        Text(
          title,
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? cyprus
                  : cultured,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w600,
              fontSize: 16.0),
        )
      ],
    );
  }

  Widget _dropDownLanguaje(BuildContext context) {
    final lang = Provider.of<LanguajeProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);

    return DropdownButton(
        hint: Container(
          margin: const EdgeInsets.only(right: 7),
          child: Text(lang.getLang.languageCode == 'es'
              ? localization.dictionary(Strings.languajeOptionSpanish)
              : localization.dictionary(Strings.languajeOptionEnglish)),
        ),
        dropdownColor: Theme.of(context).brightness == Brightness.light
            ? cultured
            : cyprus,
        style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? cyprus
                : cultured,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600,
            fontSize: 16.0),
        onChanged: (newValue) {
          _changeLang(newValue, context);
        },
        items: [
          localization.dictionary(Strings.languajeOptionSpanish),
          localization.dictionary(Strings.languajeOptionEnglish)
        ]
            .map((value) => DropdownMenuItem(
                  value: value,
                  child: Text(value),
                ))
            .toList());
  }

  Widget _dropDownTheme(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    final lang = Provider.of<LanguajeProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);

    return DropdownButton(
        hint: Container(
          margin: const EdgeInsets.only(right: 7),
          child: Text(theme.getTheme.name == 'light'
              ? localization.dictionary(Strings.themeOptionLight)
              : theme.getTheme.name == 'dark'
                  ? localization.dictionary(Strings.themeOptionDark)
                  : localization.dictionary(Strings.themeOptionSystem)),
        ),
        dropdownColor: Theme.of(context).brightness == Brightness.light
            ? cultured
            : cyprus,
        style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? cyprus
                : cultured,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600,
            fontSize: 16.0),
        onChanged: (newValue) {
          _changeTheme(newValue, context);
        },
        items: [
          localization.dictionary(Strings.themeOptionLight),
          localization.dictionary(Strings.themeOptionDark),
          localization.dictionary(Strings.themeOptionSystem)
        ]
            .map((value) => DropdownMenuItem(
                  value: value,
                  child: Text(value),
                ))
            .toList());
  }

  void _changeLang(value, BuildContext context) async {
    final langChange = Provider.of<LanguajeProvider>(context, listen: false);
    switch (value) {
      case 'Inglés':
      case 'English':
        langChange.setLanguaje = const Locale("en");
        break;
      case 'Español':
      case 'Spanish':
        langChange.setLanguaje = const Locale("es");
        break;
    }
  }

  void _changeTheme(value, BuildContext context) async {
    final themeChange = Provider.of<ThemeProvider>(context, listen: false);
    switch (value) {
      case 'Light':
      case 'Claro':
        themeChange.setTheme = ThemeMode.light;
        break;
      case 'Dark':
      case 'Oscuro':
        themeChange.setTheme = ThemeMode.dark;
        break;
      case 'System':
      case 'Sistema':
        themeChange.setTheme = ThemeMode.system;
        break;
    }
  }
}
