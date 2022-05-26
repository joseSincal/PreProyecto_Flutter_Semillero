import 'package:firebase_database/firebase_database.dart';
import 'package:pre_proyecto_universales_chat/Models/user_model.dart';

class MsgModel {
  late String id;
  late DateTime fechaEnvio;
  late int fechaEnvioEpoch;
  late String texto;
  late String tipo;
  late String usuarioid;
  late bool isMy;

  MsgModel.fromRealtime(this.id, Map<dynamic, dynamic> moreData, String uId) {
    fechaEnvio =
        DateTime.fromMillisecondsSinceEpoch(moreData['fecha_envio'] as int);
    fechaEnvioEpoch = moreData['fecha_envio'] as int;
    texto = moreData['texto'];
    tipo = moreData['type'];
    usuarioid = moreData['usuario'];
    isMy = moreData['usuario'] == uId;
  }
}
