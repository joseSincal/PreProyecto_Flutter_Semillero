import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:pre_proyecto_universales_chat/Models/user_model.dart';

class DBRepository {
  DBRepository._privateConstructor();

  static final DBRepository shared = DBRepository._privateConstructor();

  final FirebaseDatabase _db = FirebaseDatabase.instance;

  Future<void> verifyGeneralChanel(String userUid) async {
    final snapshot = await _db.ref().child('Canales/General').get();
    if (!snapshot.exists) {
      await _createGeneralChanel(userUid);
    }
  }

  Future<void> verifyUser(UserModel user) async {
    final snapshot = await _db.ref().child("Usuarios/${user.id}").get();
    if (!snapshot.exists) {
      await createUser(user);
    }
  }

  Future<void> _createGeneralChanel(String userUid) async {
    DatabaseReference ref = _db.ref("Canales/General");

    await ref.set({
      'administradores': {userUid: userUid},
      'creador': userUid,
      'descripcion': 'Grupo general',
      'fecha_creación': 123123123, // un numero
      'nombre': 'General'
    });
  }

  Future<void> createUser(UserModel user) async {
    DatabaseReference ref = _db.ref("Usuarios/${user.id}");
    await ref.set({
      'canales': {'General': 'General'},
      'change': false,
      'correo': user.email,
      'estado': true,
      'nombre': user.name,
      'urlImage': user.photo
    });

    ref = _db.ref('Canales/General/usuarios/${user.id}');
    await ref.set(user.id);
  }
}
