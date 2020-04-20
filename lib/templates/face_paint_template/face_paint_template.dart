import 'dart:ui';

import 'package:flitro/templates/face_paint_template/painting_space.dart';
import 'package:flitro/templates/face_paint_template/tool_box/tool_box.dart';
import 'package:flutter/material.dart';

class FacePaintTemplate extends StatelessWidget {
  const FacePaintTemplate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Image.asset('assets/images/face.jpg', width: 400, height: 400),
                PaintingSpace(),
              ],
            ),
          ),
          Expanded(
            child: ToolBox(),
          )
        ],
      ),
    );
  }
}
