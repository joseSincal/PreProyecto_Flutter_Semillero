import 'package:flutter/material.dart';
import 'package:pre_proyecto_universales_chat/Widgets/navigation_drawe.dart';

class PageSettings extends StatelessWidget {
  const PageSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        backgroundColor: Colors.greenAccent.shade700,
      ),
      drawer: const NavigationDrawer(),
    );
  }
}
