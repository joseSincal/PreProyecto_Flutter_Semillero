import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_colors.dart';
import 'package:pre_proyecto_universales_chat/Widgets/input_text.dart';

class PageCreateChannel extends StatelessWidget {
  const PageCreateChannel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? cultured
            : cyprus2,
        appBar: AppBar(
          title: const Text(
            'Create a new channel',
            style:
                TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.w600),
          ),
          backgroundColor:
              Theme.of(context).brightness == Brightness.light ? eden : cyprus,
        ),
        body: Container(
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(children: [
              InputText(
                  hintText: 'Name',
                  icon: CupertinoIcons.textformat_abc,
                  controller: nameController),
              InputText(
                  hintText: 'Description',
                  icon: CupertinoIcons.textformat_abc,
                  controller: nameController)
            ])));
  }
}
