import 'dart:convert';
import 'dart:typed_data';

import 'package:cine_app/widgets/widgets_globais.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/propriedades_globais.dart';
import '../models/json_to_dart.dart';

class FilmeDetalhesPage extends StatefulWidget {
  Filmes _filme = Filmes();

  FilmeDetalhesPage(Filmes filme, {super.key}) {
    _filme = filme;
  }

  @override
  State<FilmeDetalhesPage> createState() => _FilmeDetalhesPageState(_filme);
}

class _FilmeDetalhesPageState extends State<FilmeDetalhesPage> {
  Filmes _filme = Filmes();
  List<Sessoes> _listHorarioSessoes = [];

  _FilmeDetalhesPageState(Filmes filme) {
    _filme = filme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navbarColor,
      appBar: criarAppBar("Sessões"),
      body: ScrollViewCustomizado(context),
    );
  }

  formatHoraDuracaoFilme(Duration d) => d.toString().substring(0, 4);

  Widget ScrollViewCustomizado(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: _conteudoPagina(),
            ),
          ),
        );
      },
    );
  }

  Widget _conteudoPagina() {
    return Column(
      children: [
        _fotoCapaComGradient(),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              _rowFaixaEtariaIdiomaCategoria(),
              const SizedBox(height: 10),
              _tituloComSinopse(),
              const SizedBox(height: 10),
              _verificaSessoesDisponiveis()
            ],
          ),
        ),
      ],
    );
  }

  Widget _verificaSessoesDisponiveis() {
    if (_filme.sessoes != null) {
      // verifica se lista esta vazia para selecionar a primeira data
      if (_listHorarioSessoes.isEmpty) {
        DateTime dataSelecionada = DateTime.parse(_filme.sessoes![0].dataHora!);
        _listHorarioSessoes = carregarSessoesDataSelecionada(dataSelecionada)!;
      }

      var blocoSessoes = Column(
        children: [
          _criaEfeitoFuzivel(),
          const SizedBox(height: 10),
          _listaHorizontalDatasDisponiveis(),
          const SizedBox(height: 10),
          _frameSessoesDisponiveis(),
          const SizedBox(height: 10)
        ],
      );

      return blocoSessoes;
    }

    return const SizedBox();
  }

  Widget _fotoCapaComGradient() {
    return SizedBox(
      height: 230,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          _fotoCapa(_filme.fotoCapaFilme ?? ""),
          Positioned(
            bottom: -1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  tileMode: TileMode.clamp,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    navbarColor,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Image _fotoCapa(String base64) {
    Uint8List bytesImage;
    bytesImage = const Base64Decoder().convert(base64);

    Image imageMemory = Image.memory(
      bytesImage,
      height: 240,
      width: double.infinity,
      fit: BoxFit.cover,
    );
    return imageMemory;
  }

  Row _rowFaixaEtariaIdiomaCategoria() {
    const double espacoEntreComponentes = 8;
    int minutos = _filme.duracao!;
    final Duration duration = Duration(minutes: minutos);
    var duracaoFormatada = formatHoraDuracaoFilme(duration).replaceAll(':', 'h ') + "m";

    return Row(
      children: [
        _tagDeInfos("${_filme.faixaEtaria ?? ""}+", const Color(0xff494949)),
        const SizedBox(width: espacoEntreComponentes),
        _tagDeInfos(_filme.idioma ?? "", const Color(0xff494949)),
        const SizedBox(
          width: espacoEntreComponentes,
        ),
        _tagDeInfos(_filme.categoria ?? "", const Color(0xff494949)),
        const SizedBox(
          width: espacoEntreComponentes,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                children: [
                  const WidgetSpan(
                    child: Icon(
                      Icons.timer,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: duracaoFormatada,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _tagDeInfos(String texto, Color corFundo) {
    return Container(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 2.0, bottom: 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: corFundo,
      ),
      child: Text(
        texto,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Widget _tituloComSinopse() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          _filme.nomeFilme!,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          _filme.sinopse!,
          textAlign: TextAlign.justify,
          style: const TextStyle(color: Color(0xFF808080), fontSize: 11),
        ),
      ],
    );
  }

  Widget _criaEfeitoFuzivel() {
    var divisor = const Divider(
      color: Colors.white,
      height: 20,
      thickness: 0.7,
    );
    return Row(
      children: [
        Expanded(child: divisor),
        Container(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              border: Border.all(color: Colors.white, width: 1)),
          child: const Text(
            'Selecione uma data',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        Expanded(child: divisor),
      ],
    );
  }

  Widget _listaHorizontalDatasDisponiveis() {
    TextStyle style = const TextStyle(color: Colors.white, fontSize: 12);

    // remove duplicidades da lista
    List<Sessoes> uniquelist = [];

    var seen = <String>{};
    uniquelist = _filme.sessoes!
        .where(
          (sessao) => seen.add(
            DateFormat("dd/MM/yyyy").format(DateTime.parse(sessao.dataHora!)),
          ),
        )
        .toList();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          uniquelist.length,
          (index) => GestureDetector(
            onTap: () {
              DateTime dataSelecionada = DateTime.parse(uniquelist[index].dataHora!);
              setState(() {
                _listHorarioSessoes = carregarSessoesDataSelecionada(dataSelecionada)!;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(4),
                  gradient: const LinearGradient(
                    tileMode: TileMode.clamp,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black,
                      roxoPadrao,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(5),
                width: 32,
                height: 50,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat("dd").format(DateTime.parse(uniquelist[index].dataHora!)).toString(),
                      style: style,
                    ),
                    Text(DateFormat("MMM", "pt_BR").format(DateTime.parse(uniquelist[index].dataHora!)).toString(),
                        style: style),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _frameSessoesDisponiveis() {
    RichText textoSessaoComIconeHora = RichText(
      text: TextSpan(
        children: [
          const WidgetSpan(
            child: Icon(
              Icons.timer,
              size: 18,
              color: Colors.white,
            ),
          ),
          TextSpan(
            text: ' Sessões disponíveis',
            style: TextStyle(fontSize: 14, fontFamily: fonteNunito(context), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

    var result = Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xff2D302D),
        border: Border.all(width: 1, color: Colors.white),
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textoSessaoComIconeHora,
          const SizedBox(
            height: 10,
          ),
          _listaSessoesDisponiveis(_listHorarioSessoes),
        ],
      ),
    );

    return result;
  }

  Widget _listaSessoesDisponiveis(List<Sessoes> list) {
    TextStyle style = const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          list.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color(0xff494949),
                  border: Border.all(width: 1, color: Colors.white)),
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              child: Text(
                DateFormat("HH:mm").format(DateTime.parse(_listHorarioSessoes[index].dataHora!)).toString(),
                style: style,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Sessoes>? carregarSessoesDataSelecionada(DateTime dataSessaoSelecionada) {
    // filtra as datas com WHERE
    List<Sessoes> uniquelist =
        _filme.sessoes!.where((sessao) => DateTime.parse(sessao.dataHora!).day == dataSessaoSelecionada.day).toList();

    // ordena lista de sessoes pela data
    uniquelist.sort((a, b) {
      //sorting in ascending order
      return DateTime.parse(a.dataHora!).compareTo(DateTime.parse(b.dataHora!));
    });
    return dataSessaoSelecionada != null ? uniquelist : null;
  }
}
