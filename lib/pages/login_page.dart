import 'package:cine_app/helper/propriedades_globais.dart';
import 'package:cine_app/pages/cadastro_email_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../services/navigation_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _conteudoPagina(),
    );
  }

  Widget _conteudoPagina() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.clamp,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey,
            roxoPadrao,
            roxoPadrao,
          ],
        ),
        image: DecorationImage(image: AssetImage('lib/assets/movies_background.jpg'), fit: BoxFit.cover, opacity: 0.4),
      ),
      child: CustomScrollView(
        slivers: <Widget>[
          _topoPaginaAdaptadoParaTeclado(),
          _bottomAdaptadoParaEsconderTeclado(),
        ],
      ),
    );
  }

  Widget _topoPaginaAdaptadoParaTeclado() {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 50),
            child: _iconeComNomeApp(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
            child: _inputsDeTexto(),
          )
        ],
      ),
    );
  }

  Widget _bottomAdaptadoParaEsconderTeclado() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _opcoesDeAcesso(),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text.rich(
              TextSpan(
                text: 'Ainda não tem uma conta? ',
                style: const TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () => {
                      navigateToPage(context, const CadastroEmailPage())
                    },
                    text: 'Cadastre-se',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  // can add more TextSpans here...
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _iconeComNomeApp() {
    return Column(
      children: const [
        Image(
          image: AssetImage('lib/assets/tv_240px.png'),
          color: Colors.white,
          width: 140,
        ),
        Text(
          'MovieApp',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _inputsDeTexto() {
    return Column(
      children: const [
        TextField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12),
            isDense: true,
            prefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey, size: 30),
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            hintText: 'Digite seu login',
            helperText: null,
            helperStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12),
            isDense: true,
            prefixIcon: Icon(Icons.lock_outlined, color: Colors.grey, size: 30),
            suffixIcon: Icon(Icons.remove_red_eye_outlined, color: Colors.grey, size: 30),
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            hintText: 'Digite sua senha',
            helperText: null,
            helperStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
        ),
      ],
    );
  }

  // componentes: ENTRAR | ESQUECI MINHA SENHA | LEMBRAR DE MIM | CADASTRE-SE
  Widget _opcoesDeAcesso() {
    return Column(
      children: [
        _botaoComBorda(context, 'ENTRAR', () => setRootPage(context, homeRootRoute), roxoPadrao, Colors.white),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => {
                  print('TAP em ESQUECI MINHA SENHA!!!'),
                },
                child: const Text(
                  'Esqueci minha senha',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Lembrar de mim?',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Checkbox(
                    checkColor: Colors.deepPurple,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _botaoComBorda(
      BuildContext context, String tituloBotao, Function onPressedFunc, Color corBotao, Color corTextoBotao) {
    ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: TextStyle(
        fontSize: 16,
        fontFamily: fonteNunito(context),
      ),
      minimumSize: const Size.fromHeight(40),
      shape: const StadiumBorder(
          side: BorderSide(
        color: Colors.white,
        width: 1.2,
      )),
      backgroundColor: corBotao,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 100, right: 100),
      child: ElevatedButton(
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
      ),
    );
  }
}
