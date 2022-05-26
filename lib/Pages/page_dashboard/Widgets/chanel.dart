import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pre_proyecto_universales_chat/Repository/db_repository.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_colors.dart';

class Chanel extends StatelessWidget {
  final String title;
  final String subtitle;
  final String hour;

  Chanel(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.hour})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TextAvatar(
        text: title,
        shape: Shape.Circular,
        size: 50,
        numberLetters: 2,
        textColor: cultured,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          title,
          style: const TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
            fontFamily: 'Quicksand', fontSize: 13, fontWeight: FontWeight.w600),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(hour,
          style: const TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 13,
              fontWeight: FontWeight.w600)),
      onTap: () {
        //DBRepository.shared.getChanels(FirebaseAuth.instance.currentUser!.uid);
      },
    );
  }
}
