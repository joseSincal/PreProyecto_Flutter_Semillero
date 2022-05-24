import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pre_proyecto_universales_chat/Bloc/authentication/auth_bloc.dart';
import 'package:pre_proyecto_universales_chat/Localization/localization.dart';
import 'package:pre_proyecto_universales_chat/Pages/page_dashboard/page_dashboard.dart';
import 'package:pre_proyecto_universales_chat/Pages/page_login/page_login.dart';
import 'package:pre_proyecto_universales_chat/Pages/page_signup/widgets/top_header_signup.dart';
import 'package:pre_proyecto_universales_chat/Providers/languaje_provider.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_colors.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_strings.dart';
import 'package:pre_proyecto_universales_chat/Widgets/input_password.dart';
import 'package:pre_proyecto_universales_chat/Widgets/input_text.dart';
import 'package:pre_proyecto_universales_chat/Widgets/label_text.dart';
import 'package:provider/provider.dart';

class PageSignUp extends StatefulWidget {
  const PageSignUp({Key? key}) : super(key: key);

  @override
  State<PageSignUp> createState() => _PageSignUpState();
}

class _PageSignUpState extends State<PageSignUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguajeProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);

    return Scaffold(
      backgroundColor:
          Theme.of(context).brightness == Brightness.light ? salem : cyprus2,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const PageDashboard()));
          }
          else if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UnAuthenticated) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  const TopHeaderSignUp(),
                  Expanded(
                      child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 32),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                        color: Theme.of(context).brightness == Brightness.light
                            ? cultured
                            : eden),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40),
                            LabelText(
                                label:
                                    '${localization.dictionary(Strings.loginEmailLabel)} *'),
                            InputText(
                              hintText: 'example@email.com',
                              icon: Icons.email_rounded,
                              controller: _emailController,
                              validator: _emailValidator(localization),
                            ),
                            const SizedBox(height: 16),
                            LabelText(
                                label:
                                    '${localization.dictionary(Strings.loginPasswordLabel)} *'),
                            InputPassword(
                              hintText: '********',
                              icon: Icons.key_rounded,
                              controller: _passwordController,
                              validator: _passwordValidator(localization),
                            ),
                            const SizedBox(height: 32),
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 46,
                                width: 160,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<AuthBloc>(context).add(
                                        SignUpRequested(
                                          _emailController.text,
                                          _passwordController.text,
                                        ),
                                      );
                                    }
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
                                    localization
                                        .dictionary(Strings.signupButton),
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
                            const SizedBox(height: 32),
                            _logInAccountLink(context, localization, () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PageLogin()),
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ))
                ]);
          }
          return Container();
        },
      ),
    );
  }

  Widget _logInAccountLink(
      BuildContext context, AppLocalizations localization, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            localization.dictionary(Strings.loginHaveAccount),
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
              localization.dictionary(Strings.loginWithAccount),
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

  String? Function(String?) _emailValidator(AppLocalizations localization) {
    return (value) {
      if (value == null || value.isEmpty) {
        return localization.dictionary(Strings.fieldNotEmpty);
      }
      return !EmailValidator.validate(value)
          ? localization.dictionary(Strings.emailValidator)
          : null;
    };
  }

  String? Function(String?) _passwordValidator(AppLocalizations localization) {
    return (value) {
      if (value == null || value.isEmpty) {
        return localization.dictionary(Strings.fieldNotEmpty);
      }
      return value.length < 6
          ? localization.dictionary(Strings.passwordValidator)
          : null;
    };
  }
}
