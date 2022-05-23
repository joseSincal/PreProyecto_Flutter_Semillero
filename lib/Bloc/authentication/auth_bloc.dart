import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pre_proyecto_universales_chat/Models/user_model.dart';
import 'package:pre_proyecto_universales_chat/Repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc
    extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  late final StreamSubscription<User> _userSubscription;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(authRepository.currentUser.isNotEmpty
            ? AuthState.authenticated(authRepository.currentUser)
            : const AuthState.unauthenticated()) {
    on<AuthenticationUserChanged>(_onUserChanged);
    on<AuthenticationLogoutRequested>(_onLogoutRequested);
  }

  void _onUserChanged(
      AuthenticationUserChanged event, Emitter<AuthState> emit) {
    emit(
      event.user.isNotEmpty
          ? AuthState.authenticated(event.user)
          : const AuthState.unauthenticated(),
    );
  }

  void _onLogoutRequested(
      AuthenticationLogoutRequested event, Emitter<AuthState> emit) {
    unawaited(_authRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
