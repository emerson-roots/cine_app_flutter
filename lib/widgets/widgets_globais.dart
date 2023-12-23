import 'package:flutter/material.dart';

import '../helper/propriedades_globais.dart';

AppBar criarAppBar(String titulo) {
  return AppBar(
    title: Text(
      titulo,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: navbarColor,
    centerTitle: true,
  );
}

Widget botaoCorSolida(String tituloBotao, Function onPressedFunc, Color corBotao, Color corTextoBotao) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(6),
    child: Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(color: corBotao),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: corTextoBotao,
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            textStyle: const TextStyle(fontSize: 16),
          ),
          onPressed: () {
            onPressedFunc();
          },
          child: Text(tituloBotao),
        ),
      ],
    ),
  );
}
