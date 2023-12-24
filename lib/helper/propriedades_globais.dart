import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// cores
const Color navbarColor = Colors.black;
const Color menuHamburgerColor = navbarColor;
Color menuHamburgerHeaderColor = Colors.grey.shade900;

// rotas root pages
const String homeRootRoute = '/home';
const String loginRootRoute = '/login';

String? fonteNunito(BuildContext context) {
  return GoogleFonts.nunito(
    textStyle: Theme.of(context).textTheme.displayLarge,
    fontSize: 48,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  ).fontFamily;
}