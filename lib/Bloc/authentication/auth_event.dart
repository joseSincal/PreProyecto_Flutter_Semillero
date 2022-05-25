part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String username;

  SignUpRequested(this.email, this.password, this.username);
}

class GoogleSignInRequested extends AuthEvent {}

class FacebookSignInRequested extends AuthEvent {}

class TwitterSignInRequested extends AuthEvent {}

class SignOutRequested extends AuthEvent {}

/*abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthEvent {
  final User user;

  const AuthenticationUserChanged(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationLogoutRequested extends AuthEvent {}*/
