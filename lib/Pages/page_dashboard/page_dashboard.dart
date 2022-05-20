import 'package:flutter/material.dart';
import 'package:pre_proyecto_universales_chat/Widgets/navigation_drawe.dart';

class PageDashboard extends StatelessWidget {
  const PageDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blue.shade700,
      ),
      drawer: const NavigationDrawer(),
    );
  }
}
