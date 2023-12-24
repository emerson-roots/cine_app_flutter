import 'package:flutter/material.dart';

import '../widgets/widgets_globais.dart';

class CinemasPage extends StatelessWidget {
  const CinemasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: criarAppBar('Cinemas'),
      body: Center(
        child: botaoCustom(context, 'VOLTAR', () => Navigator.pop(context), Colors.blue, Colors.white, true),
      ),
    );
  }
}
