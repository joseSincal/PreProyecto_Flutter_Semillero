import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pre_proyecto_universales_chat/Bloc/authentication/auth_bloc.dart';
import 'package:pre_proyecto_universales_chat/Localization/localization.dart';
import 'package:pre_proyecto_universales_chat/Pages/page_login/widgets/top_header_login.dart';
import 'package:pre_proyecto_universales_chat/Providers/languaje_provider.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_colors.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_strings.dart';
import 'package:pre_proyecto_universales_chat/Widgets/input_password.dart';
import 'package:pre_proyecto_universales_chat/Widgets/input_text.dart';
import 'package:pre_proyecto_universales_chat/Widgets/label_text.dart';
import 'package:provider/provider.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguajeProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);

    return Scaffold(
        backgroundColor:
            Theme.of(context).brightness == Brightness.light ? salem : cyprus2,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
            } else if (state is AuthError) {}
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UnAuthenticated) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    const TopHeaderLogin(),
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 32),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? cultured
                                  : eden),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40),
                            LabelText(
                                label: localization
                                    .dictionary(Strings.loginEmailLabel)),
                            InputText(
                              hintText: 'example@email.com',
                              icon: Icons.email_rounded,
                            ),
                            const SizedBox(height: 16),
                            LabelText(
                                label: localization
                                    .dictionary(Strings.loginPasswordLabel)),
                            InputPassword(
                                hintText: '********', icon: Icons.key_rounded),
                            const SizedBox(height: 32),
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 46,
                                width: 160,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Para logearse :)
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context).brightness ==
                                                    Brightness.light
                                                ? salem
                                                : cultured),
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? cultured
                                            : cyprus),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                localization.dictionary(Strings.loginOr),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? cyprus.withAlpha(150)
                                      : cultured.withAlpha(150),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                _loginSocialMediaBtn(FontAwesomeIcons.facebookF,
                                    const Color(0xFF416BC1), () {
                                  BlocProvider.of<AuthBloc>(context).add(
                                    FacebookSignInRequested(),
                                  );
                                }),
                                const SizedBox(width: 16),
                                _loginSocialMediaBtn(FontAwesomeIcons.google,
                                    const Color(0xFFCF4333), () {
                                  BlocProvider.of<AuthBloc>(context).add(
                                    GoogleSignInRequested(),
                                  );
                                }),
                                const SizedBox(width: 16),
                                _loginSocialMediaBtn(FontAwesomeIcons.twitter,
                                    const Color(0xFF08A0E9), () {}),
                              ],
                            ),
                            const SizedBox(height: 32),
                            _createAccountLink(context, localization, () {})
                          ],
                        ),
                      ),
                    ))
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }

  Widget _createAccountLink(
      BuildContext context, AppLocalizations localization, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            localization.dictionary(Strings.loginDontAccount),
            style: TextStyle(
              fontFamily: 'Quicksand',
              color: Theme.of(context).brightness == Brightness.light
                  ? cyprus.withAlpha(150)
                  : cultured.withAlpha(150),
              fontSize: 13,
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: Text(
              localization.dictionary(Strings.loginCreateAccount),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Quicksand',
                color: Theme.of(context).brightness == Brightness.light
                    ? salem
                    : cultured,
                fontSize: 13,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _loginSocialMediaBtn(
      IconData icon, Color bgColor, VoidCallback onTap) {
    return SizedBox.fromSize(
      size: const Size(54, 54), //button width and height
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          elevation: 16,
          shadowColor: Colors.black,
          color: bgColor,
          child: InkWell(
            splashColor: Colors.white12,
            onTap: onTap,
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
