import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:pre_proyecto_universales_chat/Models/chanel_model.dart';
import 'package:pre_proyecto_universales_chat/Models/user_model.dart';
import 'package:pre_proyecto_universales_chat/Pages/page_dashboard/Widgets/chanel.dart';
import 'package:twitter_login/entity/user.dart';

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

  List<Chanel> getChanels(DatabaseEvent event, String userUid) {
    List<Chanel> chanelCards = List<Chanel>.empty(growable: true);

    List<ChanelModel> chanelsList = List<ChanelModel>.empty(growable: true);
    var chanelsMap = event.snapshot.value as Map<Object?, Object?>;
    chanelsMap.forEach((k, v) => chanelsList.add(ChanelModel.fromRealtime(
        k as String, v as Map<Object?, Object?>, userUid)));

    chanelsList.sort((chanelA, chanelB) => chanelA
            .mensajes[chanelA.mensajes.length - 1].fechaEnvio
            .isAfter(chanelB.mensajes[chanelB.mensajes.length - 1].fechaEnvio)
        ? 0
        : 1);

    for (ChanelModel chanel in chanelsList) {
      if (chanel.isMy) {
        var ultimoMsj = chanel.mensajes[chanel.mensajes.length - 1];
        chanelCards.add(Chanel(
          title: chanel.nombre,
          subtitle: ultimoMsj.texto,
          hour: _fechaRecortada(ultimoMsj.fechaEnvio),
        ));
      }
    }

    return chanelCards;
  }

  String _fechaRecortada(DateTime fecha) {
    DateTime ahora = DateTime.now();
    if (fecha.year == ahora.year &&
        fecha.month == ahora.month &&
        fecha.day == ahora.day) {
      return '${fecha.hour}:${fecha.second}';
    }
    return '${fecha.day}/${fecha.month}';
  }
}
