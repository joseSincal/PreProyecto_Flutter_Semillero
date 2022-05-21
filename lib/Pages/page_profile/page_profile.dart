import 'package:flutter/material.dart';
import 'package:pre_proyecto_universales_chat/Widgets/navigation_drawe.dart';

class PageProfile extends StatelessWidget {
  const PageProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.amber.shade700,
      ),
      drawer: const NavigationDrawer(),
    );
  }
}
