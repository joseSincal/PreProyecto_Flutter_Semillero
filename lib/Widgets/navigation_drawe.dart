import 'package:flutter/material.dart';
import 'package:pre_proyecto_universales_chat/Localization/localization.dart';
import 'package:pre_proyecto_universales_chat/Providers/languaje_provider.dart';
import 'package:pre_proyecto_universales_chat/Providers/theme_provider.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_strings.dart';
import 'package:provider/provider.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    final lang = Provider.of<LanguajeProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);

    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[buildHeader(context), buildMenuItems(context, localization)],
      )),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top
      ),
    );
  }

  Widget buildMenuItems(BuildContext context, AppLocalizations localizations) {
    return Column(
      children: [
        ListTile(
            leading: const Icon(Icons.home_rounded),
            title: Text(localizations.dictionary(Strings.navHome)),
            onTap: () {}),
          const Divider(color: Colors.black54),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: Text(localizations.dictionary(Strings.logOut)),
            onTap: () {}),
      ],
    );
  }
}
