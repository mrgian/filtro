import 'package:flutter/material.dart';

class BrushPage extends StatefulWidget {
  BrushPage({Key key}) : super(key: key);

  @override
  _BrushPageState createState() => _BrushPageState();
}

class _BrushPageState extends State<BrushPage> {
  double thickness = 10.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Brush thickness',
            style: TextStyle(fontFamily: 'cocogoose', fontSize: 20)),
        Row(
          children: <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: Container(
                  width: thickness,
                  height: thickness,
                  decoration: new BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                ),
              ),
            ),
            Slider(
              value: thickness,
              min: 1.0,
              max: 20.0,
              onChanged: (t) {
                setState(() {
                  thickness = t;
                });
              },
            ),
          ],
        )
      ],
    );
  }
}
