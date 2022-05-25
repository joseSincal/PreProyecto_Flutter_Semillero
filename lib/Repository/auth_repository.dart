import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pre_proyecto_universales_chat/Models/user_model.dart';
import 'package:pre_proyecto_universales_chat/Repository/db_repository.dart';
import 'package:twitter_login/twitter_login.dart';

class LogOutFailure implements Exception {}

class AuthRepository {
  firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  final TwitterLogin _twitterLogin;

  AuthRepository(
      {firebase_auth.FirebaseAuth? firebaseAuth,
      GoogleSignIn? googleSignIn,
      FacebookAuth? facebookAuth,
      TwitterLogin? twitterLogin})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _facebookAuth = facebookAuth ?? FacebookAuth.instance,
        _twitterLogin = twitterLogin ??
            TwitterLogin(
                apiKey: 'H31JlrCMKPuRIHXJCAdcLu0Ts',
                apiSecretKey:
                    'rVVC37WNZ90XvihipgJDcCwE0O7BjxwxcVfPZyCePtlUIb71jM',
                redirectURI: 'flutter-twitter-login://');

  Stream<UserModel?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? null : UserModel.fromFirebase(firebaseUser);
    });
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String username}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await credential.user!.updateDisplayName(username);
      await _registerUser();
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await _firebaseAuth.signInWithCredential(credential);
      await _registerUser();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logInWithFacebook() async {
    try {
      final loginResult = await _facebookAuth.login();
      final credential = firebase_auth.FacebookAuthProvider.credential(
          loginResult.accessToken!.token);
      await _firebaseAuth.signInWithCredential(credential);
      await _registerUser();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logInWithTwitter() async {
    try {
      final authResult = await _twitterLogin.login();

      final credential = firebase_auth.TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );
      await _firebaseAuth.signInWithCredential(credential);
      await _registerUser();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
        _facebookAuth.logOut(),
      ]);
      _firebaseAuth = firebase_auth.FirebaseAuth.instance;
    } on Exception {
      throw LogOutFailure();
    }
  }

  Future<void> _registerUser() async {
    UserModel user = UserModel.fromFirebase(_firebaseAuth.currentUser!);
    await DBRepository.shared.verifyGeneralChanel(user.id);
    await DBRepository.shared.verifyUser(user);
  }
}
