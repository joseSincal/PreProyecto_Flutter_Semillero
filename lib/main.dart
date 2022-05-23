import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pre_proyecto_universales_chat/Localization/localization.dart';
import 'package:pre_proyecto_universales_chat/Providers/languaje_provider.dart';
import 'package:pre_proyecto_universales_chat/Providers/theme_provider.dart';
import 'package:pre_proyecto_universales_chat/Repository/auth_repository.dart';
import 'package:pre_proyecto_universales_chat/Widgets/app.dart';
import 'package:provider/provider.dart';

void main() {
  runZonedGuarded(() => runApp(const MyApp()),
      (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<void> _appComponents;
  ThemeProvider themeProvider = ThemeProvider();
  LanguajeProvider langProvider = LanguajeProvider();

  Future<void> _initializeAC() async {
    await Firebase.initializeApp();
    await _initializeC();
    await _getCurrentTheme();
    await _getCurrentLanguaje();
  }

  Future<void> _initializeC() async {
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(!kDebugMode);

    Function onOriginalError = FlutterError.onError as Function;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      onOriginalError(errorDetails);
    };
  }

  Future<void> _getCurrentTheme() async {
    themeProvider.setTheme = await themeProvider.getDefaultTheme();
  }

  Future<void> _getCurrentLanguaje() async {
    langProvider.setLanguaje = await langProvider.getDefaultLanguaje();
  }

  @override
  void initState() {
    super.initState();
    _appComponents = _initializeAC();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _appComponents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => ThemeProvider()),
                ChangeNotifierProvider(create: (_) => LanguajeProvider()),
              ],
              child: Consumer2(builder: (context, ThemeProvider themeProvider,
                  LanguajeProvider languajeProvider, widget) {
                return MaterialApp(
                  locale: languajeProvider.getLang,
                  localizationsDelegates: const [
                    AppLocalizationsDelegate(),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('es', ''),
                    Locale('en', ''),
                  ],
                  theme: ThemeData.light(),
                  darkTheme: ThemeData.dark(),
                  themeMode: themeProvider.getTheme,
                  debugShowCheckedModeBanner: false,
                  title: 'SemiFlutter',
                  home: App(authRepository: AuthRepository()),
                );
              }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

/*

return const MaterialApp(
            home: CircularProgressIndicator(),
          );

 */