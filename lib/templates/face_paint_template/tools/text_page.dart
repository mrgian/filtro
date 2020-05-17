import 'package:flitro/templates/face_paint_template/button.dart';
import 'package:flitro/templates/face_paint_template/paint_data.dart';
import 'package:flitro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class TextPage extends StatelessWidget {
  const TextPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paintData = Provider.of<PaintData>(context);
    paintData.currentTool = Tool.text;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Text('Text color',
                    style: TextStyle(fontFamily: 'cocogoose', fontSize: 20)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
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
                          color: paintData.textColor, shape: BoxShape.circle),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: MyButton(
                    text: 'Select color',
                    onTap: () {
                      selectColor(context, paintData);
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
                Text('Text size',
                    style: TextStyle(fontFamily: 'cocogoose', fontSize: 20)),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Slider(
                  activeColor: MyColors.black,
                  inactiveColor: MyColors.darkGrey,
                  value: paintData.textSize,
                  min: 5.0,
                  max: 40.0,
                  onChanged: (t) {
                    paintData.textSize = t;
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Text('Text preview',
                    style: TextStyle(fontFamily: 'cocogoose', fontSize: 20)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    paintData.text,
                    style: TextStyle(
                        fontFamily: 'cocogoose',
                        fontSize: paintData.textSize,
                        color: paintData.textColor),
                  ),
                ),
                MyButton(text: 'Edit', onTap: null),
                MyButton(text: 'Add', onTap: () => paintData.addText()),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyButton(
                text: 'Back',
                onTap: () {
                  paintData.currentPage = PaintData.pages[0];
                },
              ),
              MyButton(
                text: 'Undo',
                onTap: () {
                  paintData.undo();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  selectColor(BuildContext context, var paintData) {
    Color pickerColor = paintData.textColor;

    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text(
          'Pick a color',
          style: TextStyle(
              fontFamily: 'cocogoose', fontSize: 20, color: MyColors.black),
        ),
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
          MyButton(
            text: 'Select',
            onTap: () {
              paintData.textColor = pickerColor;
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
