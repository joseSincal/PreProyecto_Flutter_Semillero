import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pre_proyecto_universales_chat/Bloc/authentication/auth_bloc.dart';
import 'package:pre_proyecto_universales_chat/Localization/localization.dart';
import 'package:pre_proyecto_universales_chat/Models/user_model.dart';
import 'package:pre_proyecto_universales_chat/Pages/page_dashboard/page_dashboard.dart';
import 'package:pre_proyecto_universales_chat/Pages/page_profile/page_profile.dart';
import 'package:pre_proyecto_universales_chat/Pages/page_settings/page_settings.dart';
import 'package:pre_proyecto_universales_chat/Providers/languaje_provider.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_colors.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_strings.dart';
import 'package:provider/provider.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguajeProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);

    return Drawer(
      backgroundColor: cultured,
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context, localization)
        ],
      )),
    );
  }

  Widget buildHeader(BuildContext context) {
    UserModel user = UserModel.fromFirebase(FirebaseAuth.instance.currentUser!);

    return Container(
      padding: EdgeInsets.only(
          top: 34 + MediaQuery.of(context).padding.top, bottom: 24),
      child: Column(children: [
        CircleAvatar(
            radius: 52,
            backgroundColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: user.photo != ''
                  ? CachedNetworkImage(
                      imageUrl: user.photo,
                    )
                  : TextAvatar(
                      text: user.name == '-' ? user.email : user.name,
                      size: 75,
                      numberLetters: 2,
                      textColor: cultured,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
            )),
        const SizedBox(height: 12),
        Text(
          user.name,
          style: TextStyle(fontSize: 28, color: cyprus2),
        ),
        Text(
          user.email,
          style: TextStyle(fontSize: 16, color: cyprus2),
        )
      ]),
    );
  }

  Widget buildMenuItems(BuildContext context, AppLocalizations localizations) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 15,
        children: [
          buildItemMenu(
              icon: Icons.home_rounded,
              title: localizations.dictionary(Strings.navHome),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const PageDashboard()));
              }),
          buildItemMenu(
              icon: Icons.person_rounded,
              title: localizations.dictionary(Strings.navProfile),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const PageProfile()));
              }),
          buildItemMenu(
              icon: Icons.settings_rounded,
              title: localizations.dictionary(Strings.navSetting),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const PageSettings()));
              }),
          const Divider(color: Colors.black54),
          buildItemMenu(
              icon: Icons.logout_rounded,
              title: localizations.dictionary(Strings.logOut),
              onTap: () {
                context.read<AuthBloc>().add(SignOutRequested());
              }),
        ],
      ),
    );
  }

  Widget buildItemMenu(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
        leading: Icon(icon, color: cyprus2),
        title: Text(title, style: TextStyle(color: cyprus2)),
        onTap: onTap);
  }
}
