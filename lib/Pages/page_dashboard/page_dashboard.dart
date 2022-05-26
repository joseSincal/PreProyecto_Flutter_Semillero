import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pre_proyecto_universales_chat/Localization/localization.dart';
import 'package:pre_proyecto_universales_chat/Pages/page_dashboard/Widgets/chanel.dart';
import 'package:pre_proyecto_universales_chat/Providers/languaje_provider.dart';
import 'package:pre_proyecto_universales_chat/Repository/db_repository.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_colors.dart';
import 'package:pre_proyecto_universales_chat/Widgets/navigation_drawe.dart';
import 'package:provider/provider.dart';

class PageDashboard extends StatelessWidget {
  const PageDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //DBRepository.shared.getChanels(FirebaseAuth.instance.currentUser!.uid);
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('Canales');
    User user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? cultured
            : cyprus2,
        appBar: AppBar(
          title: const Text(
            'UniChat',
            style:
                TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.w600),
          ),
          backgroundColor:
              Theme.of(context).brightness == Brightness.light ? eden : cyprus,
        ),
        drawer: const NavigationDrawer(),
        body: StreamBuilder(
          stream: starCountRef.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data as DatabaseEvent;
              return ListView(
                  children: DBRepository.shared.getChanels(data, user.uid));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}


/**
 
ListView(children: [
                Chanel(
                    title: 'General',
                    subtitle: 'JS: Hola mundo',
                    hour: '6:30 pm'),
                Chanel(
                    title: 'Amigos',
                    subtitle: 'Tu: JAJAJAJAJA xD',
                    hour: '6:22 pm'),
                Chanel(
                    title: 'Prueba',
                    subtitle:
                        'Testing: Bienvenido compa!! como esta en es maravilloso dia',
                    hour: 'Ayer'),
              ]);

 */