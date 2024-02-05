import 'package:cine_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../helper/propriedades_globais.dart';
import '../services/navigation_service.dart';
import '../widgets/widgets_globais.dart';

class CadastroEmailPage extends StatefulWidget {
  final bool isPaginaCadastroSenha;

  const CadastroEmailPage({Key? key, this.isPaginaCadastroSenha = false}) : super(key: key);

  @override
  State<CadastroEmailPage> createState() => _CadastroEmailPageState();
}

class _CadastroEmailPageState extends State<CadastroEmailPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: criarAppBar('Cadastrar e-mail'),
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
              'Insira um e-mail válido.',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text(
                'Olá, iremos te auxiliar a criar seu cadastro. Para prosseguir, é necessário inserir um e-mail válido. Fique tranquilo, suas informações estão protegidas.',
                style: TextStyle(color: Colors.white60),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Lottie.asset('lib/assets/register.json', height: 240),
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
                hintText: 'Digite um e-mail válido',
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
                child: botaoCustom(context, 'PRÓXIMO', () => navigateToPage(context, const LoginPage()),
                    Colors.purple.shade900, Colors.white, true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
