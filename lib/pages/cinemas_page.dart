import 'dart:convert';
import 'package:cine_app/helper/propriedades_globais.dart';
import 'package:cine_app/services/navigation_service.dart';
import 'package:flutter/material.dart';

import '../models/json_to_dart.dart';
import '../widgets/widgets_globais.dart';
import 'filmes_page.dart';

class CinemasPage extends StatefulWidget {
  const CinemasPage({Key? key}) : super(key: key);

  @override
  State<CinemasPage> createState() => _CinemasPageState();
}

class _CinemasPageState extends State<CinemasPage> {
  List<Cinema> _listaCinemas = [];

  void _getAllCinemas() {
    setState(() {
      List jsonCinemas = jsonDecode(json())['Cinema'] as List;
      List<Cinema> tagObjs = jsonCinemas.map((tagJson) => Cinema.fromJson(tagJson)).toList();
      _listaCinemas = tagObjs;
    });
  }

  @override
  Widget build(BuildContext context) {
    _getAllCinemas();

    return Scaffold(
      backgroundColor: navbarColor,
      appBar: criarAppBar('Cinemas'),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _listaCinemas.length,
              itemBuilder: (context, index) {
                return _cardCinema(_listaCinemas[index], context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardCinema(Cinema cinema, BuildContext context) {
    String primeiraFotoEmBase64 = cinema.fotosCinema!.isNotEmpty ? cinema.fotosCinema![0].foto.toString() : "";

    return GestureDetector(
      child: Card(
        color: roxoPadrao,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
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
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(
                    maxHeight: 140,
                  ),
                  color: Colors.transparent,
                  child: getImageBase64OrDefault(primeiraFotoEmBase64),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 10.0),
                  Text(
                    cinema.nomeCinema ?? "",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${cinema.notaAvaliacao} ⭐ (767)',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${cinema.cidade?.descricao}  • 0 km",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  const Text(
                    "Ver filmes >",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        navigateToPage(context, FilmesPage(cinema));
      },
    );
  }
}
