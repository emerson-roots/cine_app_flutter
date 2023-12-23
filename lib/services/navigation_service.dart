import 'package:flutter/material.dart';

void navigateToPage(BuildContext context, Widget navigablePage) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => navigablePage,
    ),
  );
}

void setRootPage(BuildContext context, String rotaNomeada) {
  Navigator.of(context).pushNamedAndRemoveUntil(rotaNomeada, (route) => false);
}
