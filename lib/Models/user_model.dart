import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class UserModel {
  late String id;
  late String email;
  late String name;
  late String photo;

  UserModel.fromFirebase(firebase_auth.User user) {
    id = user.uid;
    email = user.email ?? '-';
    name = user.displayName ?? '-';
    photo = user.photoURL ?? '';
  }
}
