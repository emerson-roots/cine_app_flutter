import 'package:cine_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../helper/propriedades_globais.dart';
import '../services/navigation_service.dart';
import '../widgets/widgets_globais.dart';

class CadastroConclusaoPage extends StatefulWidget {

  const CadastroConclusaoPage({Key? key}) : super(key: key);

  @override
  State<CadastroConclusaoPage> createState() => _CadastroConclusaoPageState();
}

class _CadastroConclusaoPageState extends State<CadastroConclusaoPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: criarAppBar('Conclusão'),
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
              'Parabéns.',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text(
                'Seu cadastro foi concluído com sucesso. Vá para o login e entre com o e-mail e senha cadastrada.',
                style: TextStyle(color: Colors.white60),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Lottie.asset('lib/assets/success.json', height: 380),
            const SizedBox(height: 10),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: botaoCustom(context, 'LOGIN', () => navigateToPage(context, const LoginPage()),
                    Colors.purple.shade900, Colors.white, true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
