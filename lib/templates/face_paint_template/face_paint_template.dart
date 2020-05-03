import 'dart:ui';

import 'package:flitro/templates/face_paint_template/paint_data.dart';
import 'package:flitro/templates/face_paint_template/painting_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FacePaintTemplate extends StatelessWidget {
  const FacePaintTemplate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaintData(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Editor', style: TextStyle(fontFamily: 'cocogoose')),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Stack(
                children: <Widget>[
                  Image.asset('assets/images/face.jpg',
                      width: 400, height: 400),
                  PaintingSpace(),
                ],
              ),
            ),
            ToolBox(),
          ],
        ),
      ),
    );
  }
}

class ToolBox extends StatelessWidget {
  const ToolBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paintData = Provider.of<PaintData>(context);
    return Expanded(child: paintData.currentPage);
  }
}
