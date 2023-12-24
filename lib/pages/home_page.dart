import 'package:cine_app/pages/cinemas_page.dart';
import 'package:cine_app/widgets/widgets_globais.dart';
import 'package:flutter/material.dart';

import '../services/navigation_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Esta será a home page!',
            ),
            const SizedBox(height: 20.0),

            botaoCustom(context,
                'Ir para Cinemas', () => navigateToPage(context, const CinemasPage()), Colors.deepPurple, Colors.white,true)
          ],
        ),
      ),
    );
  }
}
