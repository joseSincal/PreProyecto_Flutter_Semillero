import 'package:pre_proyecto_universales_chat/Models/msj_model.dart';

class ChanelModel {
  late String id;
  late String nombre;
  late String descripcion;
  late DateTime fechaCreacion;
  late String idCreador;
  late List<MsgModel> mensajes;
  late List<String> usuarios;
  late bool isMy;

  ChanelModel.fromRealtime(
      this.id, Map<dynamic, dynamic> moreData, String uId) {
    nombre = moreData['nombre'];
    descripcion = moreData['descripcion'];
    fechaCreacion =
        DateTime.fromMillisecondsSinceEpoch(moreData['fecha_creacion'] as int);
    idCreador = moreData['creador'];

    List<MsgModel> listMsj = List<MsgModel>.empty(growable: true);

    var msjMap = moreData['mensajes'] as Map<Object?, Object?>;
    msjMap.forEach((k, v) => listMsj.add(
        MsgModel.fromRealtime(k as String, v as Map<Object?, Object?>, uId)));
    if (listMsj.length > 1) {
      listMsj.sort(
          (msjA, msjB) => msjA.fechaEnvio.isAfter(msjB.fechaEnvio) ? 1 : 0);
    }
    mensajes = listMsj;

    List<String> listUser = List<String>.empty(growable: true);
    var userMap = moreData['usuarios'] as Map<Object?, Object?>;
    userMap.forEach((k, v) => listUser.add(v as String));
    usuarios = listUser;

    isMy = usuarios.contains(uId);
  }
}
