import 'package:flitro/template_selector/template_card.dart';
import 'package:flutter/material.dart';

class TemplateSelector extends StatelessWidget {
  const TemplateSelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a template',
            style: TextStyle(fontFamily: 'cocogoose')),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          TemplateCard(
            name: 'Face paint',
            description: 'Draw or add texts and image to your face',
            image: 'assets/images/face_paint_image.png',
          ),
          TemplateCard(
            name: 'Random image sequence',
            description: 'Just select your images',
            image: 'assets/images/random_sequence_image.png',
          ),
          Expanded(
              child: Container(
            child: Center(
                child: Text(
              'More templates coming soon',
              style: TextStyle(color: Colors.grey[600]),
            )),
          ))
        ],
      ),
    );
  }
}
