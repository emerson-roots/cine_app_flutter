import 'package:cine_app/models/json_to_dart.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
  List<Filmes> _filmes = [];

  _FilmesPageState(Cinema cinema) {
    _cinema = cinema;
    _filmes = _cinema?.filmes ?? List.empty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navbarColor,
      appBar: criarAppBar(_cinema.nomeCinema!),
      body: _conteudoPagina(),
    );
  }

  Widget _conteudoPagina() {
    if (_filmes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'lib/assets/oh_no_not_found.json',
              height: 180,
              alignment: Alignment.center,
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 15.0,
                top: 15.0,
              ),
              child: Text(
                textAlign: TextAlign.center,
                "Desculpe, este cinema não possui filmes em cartaz!",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      );
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _filmes?.length ?? 0,
            itemBuilder: (context, index) {
              return _cardFilme(_filmes![index], context);
            },
          ),
        ),
      ],
    );
  }

  Widget _cardFilme(Filmes filme, BuildContext context) {
    String capaFotoFilme = filme.fotoCapaFilme!.isNotEmpty ? filme.fotoCapaFilme.toString() : "";

    return GestureDetector(
      child: Card(
        color: roxoPadrao,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Colors.white30,
            width: 1,
          ),
        ),
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Container(
                          constraints: const BoxConstraints(
                            maxHeight: 120,
                            maxWidth: 85,
                          ),
                          color: Colors.transparent,
                          child: getImageBase64OrDefault(capaFotoFilme),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${filme.nomeFilme ?? ""}",
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _linhaDetalheFilme('Diretor', filme.diretor ?? ""),
                      _linhaDetalheFilme('Duração', "${filme.duracao ?? ""}"),
                      _linhaDetalheFilme('Idioma', filme.idioma ?? ""),
                      Text(
                        "${filme.notaAvaliacao ?? ""} ⭐",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        //navigateToPage(context, FilmeDetalhePage(filme));
      },
    );
  }

  Row _linhaDetalheFilme(String tituloLabel, String descricaoLabel) {
    return Row(
      children: [
        Text(
          '$tituloLabel: ',
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ),
        Text(
          descricaoLabel,
          style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
