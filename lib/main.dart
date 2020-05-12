import 'package:flutter/material.dart';
import 'package:flitro/home/home.dart';
import 'package:flitro/utils/colors.dart';

import 'utils/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filtro',
      theme:
          ThemeData(primaryColor: MyColors.white, accentColor: MyColors.black),
      home: Home(),
    );
  }
}
