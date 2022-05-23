import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pre_proyecto_universales_chat/Bloc/authentication/auth_bloc.dart';
import 'package:pre_proyecto_universales_chat/Pages/page_dashboard/page_dashboard.dart';
import 'package:pre_proyecto_universales_chat/Pages/page_login/page_login.dart';
import 'package:pre_proyecto_universales_chat/Repository/auth_repository.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: ((context) => AuthRepository()),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const PageDashboard();
            }
            return const PageLogin();
          },
        ),
      ),
    );
  }
}

/*class App extends StatelessWidget {
  final AuthRepository authRepository;

  const App({Key? key, required this.authRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authRepository,
      child: BlocProvider(
        create: (_) => AuthBloc(authRepository: authRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<AuthStatus>(
      state: context.select((AuthBloc authBloc) => authBloc.state.status),
      onGeneratePages: (status, pages) {
        switch (status) {
          case AuthStatus.authenticated:
            return const [MaterialPage<void>(child: PageDashboard())];
          case AuthStatus.unauthenticated:
            return const [MaterialPage<void>(child: PageLogin())];
        }
      },
    );
  }
}*/
