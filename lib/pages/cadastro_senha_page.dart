import 'package:cine_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../helper/propriedades_globais.dart';
import '../services/navigation_service.dart';
import '../widgets/widgets_globais.dart';

class CadastroSenhaPage extends StatefulWidget {

  const CadastroSenhaPage({Key? key}) : super(key: key);

  @override
  State<CadastroSenhaPage> createState() => _CadastroSenhaPageState();
}

class _CadastroSenhaPageState extends State<CadastroSenhaPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: criarAppBar('Cadastrar senha'),
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
            const SizedBox(height: 40),
            const Text(
              'Insira uma senha.',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text(
                'Para finalizar seu cadastro, insira uma senha. Lembre-se, uma senha forte é composta por letras maiúsculas, minúsculas e números!',
                style: TextStyle(color: Colors.white60),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Lottie.asset('lib/assets/security.json', height: 240),
            const SizedBox(height: 10),
            const TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(12),
                isDense: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                hintText: 'Digite uma senha forte',
                helperText: null,
                helperStyle: TextStyle(
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: botaoCustom(context, 'FINALIZAR', () => navigateToPage(context, const LoginPage()),
                    Colors.purple.shade900, Colors.white, true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
