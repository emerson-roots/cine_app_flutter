import 'package:cine_app/pages/home_page.dart';
import 'package:cine_app/pages/login_page.dart';
import 'package:cine_app/services/navigation_service.dart';
import 'package:cine_app/widgets/widgets_globais.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helper/propriedades_globais.dart';

// https://docs.flutter.dev/cookbook/design/drawer
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(fontFamily: fonteNunito(context)),
      home: const LoginPage(),
      routes: <String, WidgetBuilder>{
        // Set routes for using the Navigator.
        homeRootRoute: (BuildContext context) => const MyMenuHamburguerPage(title: appTitle),
        loginRootRoute: (BuildContext context) => const LoginPage()
      },
    );
  }
}

class MyMenuHamburguerPage extends StatefulWidget {
  const MyMenuHamburguerPage({super.key, required this.title});

  final String title;

  @override
  State<MyMenuHamburguerPage> createState() => _MyMenuHamburguerPageState();
}

class _MyMenuHamburguerPageState extends State<MyMenuHamburguerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: navbarColor,
        shadowColor: Colors.transparent,
      ),
      body: const Center(
        child: HomePage(),
      ),
      drawer: _criaMenuHamburguer(),
    );
  }

  Widget _criaMenuHamburguer() {
    return Drawer(
      backgroundColor: menuHamburgerColor,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: menuHamburgerHeaderColor,
            ),
            child: Text(
              'Drawer Menu Header',
              style: TextStyle(color: Colors.white),
            ),
          ),
          _itemMenu(context, "Home", const HomePage(), Icons.home),
          _itemMenu(context, "Logout", null, Icons.login_outlined, true, loginRootRoute),
        ],
      ),
    );
  }

  Widget _itemMenu(BuildContext context, String titulo, Widget? navigablePage, IconData icon,
      [bool isRootPage = false, String? nomeRota]) {
    return ListTile(
      textColor: Colors.white,
      title: _buildButtonRow(Colors.white, icon, titulo),
      onTap: () {
        // fecha menu hamburguer antes da navegacao
        Navigator.pop(context);

        if (isRootPage) {
          setRootPage(context, nomeRota.toString());
          return;
        }
        // navega para page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigablePage!),
        );
      },
    );
  }
}

// template de botao que recebe uma cor, um icone e um texto como parametros
Row _buildButtonRow(Color color, IconData icon, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(icon, color: color),
      Container(
        margin: const EdgeInsets.only(left: 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    ],
  );
}
