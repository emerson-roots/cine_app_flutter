import 'package:cine_app/helper/propriedades_globais.dart';
import 'package:cine_app/widgets/widgets_globais.dart';
import 'package:flutter/material.dart';

import '../services/navigation_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: botaoCorSolida('Logar', () => setRootPage(context, homeRootRoute), Colors.black, Colors.white),
      ),
    );
  }
}
