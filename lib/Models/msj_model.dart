class MsgModel {
  late String id;
  late DateTime fechaEnvio;
  late String texto;
  late String tipo;
  late String usuario;
  late bool isMy;

  MsgModel.fromRealtime(this.id, Map<dynamic, dynamic> moreData, String uId) {
    fechaEnvio =
        DateTime.fromMillisecondsSinceEpoch(moreData['fecha_envio'] as int);
    texto = moreData['texto'];
    tipo = moreData['type'];
    usuario = moreData['usuario'];
    isMy = moreData['usuario'] == uId;
  }
}
