import 'dart:convert';

import 'package:cine_app/models/json_to_dart.dart';
import 'package:flutter/material.dart';

import '../helper/propriedades_globais.dart';
import '../widgets/widgets_globais.dart';

class FilmesPage extends StatefulWidget {

  Cinema _cinema = Cinema();

  FilmesPage(Cinema cinema, {super.key}) {
    _cinema = cinema;
  }

  @override
  State<FilmesPage> createState() => _FilmesPageState(_cinema);
}

class _FilmesPageState extends State<FilmesPage> {

  Cinema _cinema = Cinema();

  _FilmesPageState(Cinema cinema) {
    _cinema = cinema;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: navbarColor, appBar: criarAppBar(_cinema.nomeCinema!), body: _conteudoPagina());
  }

  Widget _conteudoPagina() {
    String qtdFilmes = _cinema.filmes != null ? _cinema.filmes!.length.toString() : "0";
    return Center(
      child: Text(
        style: const TextStyle(fontSize: 20, color: Colors.white),
        "${_cinema.nomeCinema!}\n\nQtd Filmes: $qtdFilmes",
      ),
    );
  }
}
