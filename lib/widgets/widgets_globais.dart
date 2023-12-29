import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

ElevatedButton botaoCustom(BuildContext context, String tituloBotao, Function onPressedFunc, Color corBotao,
    Color corTextoBotao, bool isArredondado, [bool isExpandirHorizontalmente = false]) {

  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: TextStyle(
      fontSize: 16,
      fontFamily: fonteNunito(context),
    ),
    minimumSize: isExpandirHorizontalmente ? const Size.fromHeight(40) : null,
    shape: isArredondado ? StadiumBorder() : null,
    backgroundColor: corBotao,
  );

  return ElevatedButton(
    style: style,
    onPressed: () {
      onPressedFunc();
    },
    child: Text(
      tituloBotao,
      style: TextStyle(
        color: corTextoBotao,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Image getImageBase64OrDefault(String name) {
  if (name.isEmpty) {
    String diretorioFoto = 'lib/assets/cinema_padrao.jpg';
    Image imageAsset = Image.asset(
      diretorioFoto,
      height: 140,
      width: double.infinity,
      fit: BoxFit.cover,
    );
    return imageAsset;
  } else {
    Uint8List bytesImage;
    bytesImage = const Base64Decoder().convert(name);

    Image imageMemory = Image.memory(
      bytesImage,
      height: 140,
      width: double.infinity,
      fit: BoxFit.cover,
    );
    return imageMemory;
  }
}
