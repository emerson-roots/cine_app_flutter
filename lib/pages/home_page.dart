import 'package:cine_app/helper/propriedades_globais.dart';
import 'package:cine_app/pages/cinemas_page.dart';
import 'package:cine_app/widgets/widgets_globais.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/dropdown_localidade.dart';
import '../services/navigation_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// propriedades e variaveis
List<Widget> opcoes = <Widget>[Text('Cidade'), Text('Região')];
final List<bool> _opcoesSelecionada = <bool>[true, false];
List<DropdownLocalidade> listLocalidade = [
  DropdownLocalidade(0, 'Praia Grande'),
  DropdownLocalidade(1, 'São Vicente'),
  DropdownLocalidade(2, 'Santos'),
];

class _HomePageState extends State<HomePage> {
  DropdownLocalidade? dropdownValue = null; // = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navbarColor,
      body: ScrollViewCustomizado(context),
    );
  }

  Widget ScrollViewCustomizado(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: _conteudoDaPagina(),
            ),
          ),
        );
      },
    );
  }

  Widget _conteudoDaPagina() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bem-vindo!',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text(
                'Para prosseguir, selecione uma cidade ou região para carregar os cinemas de acordo com a localidade selecionada.',
                style: TextStyle(color: Colors.white60),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Lottie.asset('lib/assets/location_animation.json', height: 280),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                    child: Column(children: [
                      _customSegmentedControl(),
                      _comboboxLocalidade(),
                    ]),
                  ),
                )
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _botaoProximo(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _comboboxLocalidade() {
    return DropdownButton<DropdownLocalidade>(
      hint: Text("Selecione...", style: TextStyle(color: Colors.grey[700])),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (DropdownLocalidade? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: listLocalidade.map<DropdownMenuItem<DropdownLocalidade>>((DropdownLocalidade item) {
        return DropdownMenuItem<DropdownLocalidade>(
          value: item,
          child: Text(item.descricao),
        );
      }).toList(),
    );
  }

  Widget _botaoProximo() {
    String tituloBotao = 'PRÓXIMO';

    if (dropdownValue != null) {
      return botaoCustom(context, tituloBotao, () => navigateToPage(context, const CinemasPage()),
          Colors.purple.shade900, Colors.white, true);
    } else {
      return botaoCustom(
          context,
          tituloBotao,
          () => _dialogBuilder(context, 'Selecione...', 'Obrigatório selecionar a localidade para prosseguir.'),
          Colors.purple.shade900,
          Colors.white,
          true);
    }
  }

  Future<void> _dialogBuilder(BuildContext context, String titulo, String mensagem) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            titulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(mensagem),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'OKAY',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // segmented control
  ToggleButtons _customSegmentedControl() {
    return ToggleButtons(
      direction: Axis.horizontal,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      selectedBorderColor: Colors.white,
      borderColor: Colors.white,
      selectedColor: Colors.white,
      fillColor: Colors.grey[700],
      color: Colors.white,
      constraints: const BoxConstraints(
        minHeight: 20.0,
        minWidth: 86.0,
      ),
      isSelected: _opcoesSelecionada,
      children: opcoes,
      onPressed: (int index) {
        setState(() {
          // The button that is tapped is set to true, and the others to false.
          for (int i = 0; i < _opcoesSelecionada.length; i++) {
            _opcoesSelecionada[i] = i == index;
          }
          print(index);
        });
      },
    );
  }
}
