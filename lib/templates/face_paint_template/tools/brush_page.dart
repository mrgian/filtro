import 'package:flitro/templates/face_paint_template/paint_data.dart';
import 'package:flitro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class BrushPage extends StatelessWidget {
  const BrushPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paintData = Provider.of<PaintData>(context);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Text('Brush thickness',
                  style: TextStyle(fontFamily: 'cocogoose', fontSize: 20)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 50,
                height: 50,
                child: Center(
                  child: Container(
                    width: paintData.thickness,
                    height: paintData.thickness,
                    decoration: new BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                  ),
                ),
              ),
              Expanded(
                child: Slider(
                  activeColor: MyColors.black,
                  inactiveColor: MyColors.darkGrey,
                  value: paintData.thickness,
                  min: 1.0,
                  max: 20.0,
                  onChanged: (t) {
                    paintData.thickness = t;
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Text('Brush color',
                  style: TextStyle(fontFamily: 'cocogoose', fontSize: 20)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 50,
                height: 50,
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: new BoxDecoration(
                        color: paintData.color, shape: BoxShape.circle),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: GestureDetector(
                  onTap: () => selectColor(context, paintData),
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyColors.black,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Select color...',
                        style: TextStyle(
                            fontFamily: 'cocogoose',
                            fontSize: 15,
                            color: MyColors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                paintData.currentPage = PaintData.pages[0];
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.black,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Back',
                      style: TextStyle(
                          fontFamily: 'cocogoose',
                          fontSize: 15,
                          color: MyColors.white),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: MyColors.black,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Undo',
                    style: TextStyle(
                        fontFamily: 'cocogoose',
                        fontSize: 15,
                        color: MyColors.white),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  selectColor(BuildContext context, var paintData) {
    Color pickerColor = paintData.color;

    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: (color) {
              pickerColor = color;
            },
            showLabel: false,
            enableAlpha: false,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Select'),
            onPressed: () {
              paintData.color = pickerColor;
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
