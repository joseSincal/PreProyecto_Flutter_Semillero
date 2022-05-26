import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:pre_proyecto_universales_chat/Models/msj_model.dart';
import 'package:pre_proyecto_universales_chat/Models/user_model.dart';
import 'package:pre_proyecto_universales_chat/Repository/db_repository.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_colors.dart';
import 'package:pre_proyecto_universales_chat/Widgets/style.dart';

class PageChat extends StatelessWidget {
  final String chanelId;
  final String name;

  const PageChat({Key? key, required this.chanelId, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('Canales/$chanelId');
    User user = FirebaseAuth.instance.currentUser!;
    TextEditingController submitedController = TextEditingController();

    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? cultured
            : cyprus2,
        appBar: AppBar(
          title: Text(
            name,
            style: const TextStyle(
                fontFamily: 'Quicksand', fontWeight: FontWeight.w600),
          ),
          backgroundColor:
              Theme.of(context).brightness == Brightness.light ? eden : cyprus,
        ),
        body: StreamBuilder(
          stream: starCountRef.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data as DatabaseEvent;
              return Column(children: [
                Expanded(
                    child: GroupedListView<MsgModel, DateTime>(
                        padding: const EdgeInsets.all(8),
                        sort: false,
                        useStickyGroupSeparators: true,
                        floatingHeader: true,
                        elements:
                            DBRepository.shared.getMessages(data, user.uid),
                        groupBy: (msg) => DateTime(msg.fechaEnvio.year,
                            msg.fechaEnvio.month, msg.fechaEnvio.day),
                        groupHeaderBuilder: (MsgModel msg) => SizedBox(
                              height: 40,
                              child: Center(
                                child: Card(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? eden
                                      : cyprus,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      DateFormat.yMMMd().format(msg.fechaEnvio),
                                      style: TextStyle(color: cultured),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        itemBuilder: (context, MsgModel msg) => Container(
                              margin: msg.isMy
                                  ? const EdgeInsets.only(left: 35)
                                  : const EdgeInsets.only(right: 35),
                              child: Align(
                                alignment: msg.isMy
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Card(
                                    color: msg.isMy ? oceanGrean : cultured,
                                    elevation: 8,
                                    child: Column(
                                      crossAxisAlignment: msg.isMy
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        usuarioNombre(msg.usuarioid, msg.isMy),
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            msg.texto,
                                            style: TextStyle(
                                                color: msg.isMy
                                                    ? cultured
                                                    : cyprus,
                                                fontFamily: 'Quicksand',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ))),
                Container(
                  margin: const EdgeInsets.only(bottom: 5, top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: 335,
                          child: TextField(
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 3,
                              textCapitalization: TextCapitalization.sentences,
                              controller: submitedController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : cyprus2,
                                  enabledBorder: getInputBorderStyle(context),
                                  focusedBorder: getInputBorderStyle(context),
                                  contentPadding: const EdgeInsets.all(12),
                                  hintText: 'Type Your Message here...'))),
                      ElevatedButton(
                        onPressed: () async {
                          if (submitedController.text.isNotEmpty) {
                            await DBRepository.shared.sendMessage(
                                submitedController.text, chanelId, user.uid);
                            submitedController.text = '';
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                              Theme.of(context).brightness == Brightness.light
                                  ? eden
                                  : cyprus,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                        ),
                        child: const Center(
                            child: Icon(CupertinoIcons.paperplane_fill)),
                      )
                    ],
                  ),
                )
              ]);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget usuarioNombre(String id, bool isMy) {
    return FutureBuilder(
        future: DBRepository.shared.getUser(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel user = snapshot.data as UserModel;
            return Container(
                margin: const EdgeInsets.only(left: 12, top: 12, right: 12),
                child: Text(
                  user.name == '' ? user.email : user.name,
                  style: TextStyle(
                      color: isMy ? cultured : cyprus,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ));
          }
          return const Text('Anonimo');
        });
  }
}
