import 'package:flitro/templates/face_paint_template/button.dart';
import 'package:flitro/templates/face_paint_template/paint_data.dart';
import 'package:flitro/utils/colors.dart';
import 'package:flitro/utils/scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paintData = Provider.of<PaintData>(context);
    paintData.currentTool = Tool.image;
    return WillPopScope(
      onWillPop: () => onWillPop(paintData),
      child: SingleChildScrollViewWithScrollbar(
        scrollbarColor: Theme.of(context).accentColor.withOpacity(0.75),
        scrollbarThickness: 4.0,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: MyColors.lightGrey,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Text('Image size',
                            style: TextStyle(
                                fontFamily: 'cocogoose', fontSize: 20)),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Slider(
                          activeColor: MyColors.black,
                          inactiveColor: MyColors.darkGrey,
                          value: paintData.imageSize,
                          min: 40.0,
                          max: 300.0,
                          onChanged: (t) {
                            paintData.imageSize = t;
                          },
                          onChangeEnd: (t) {
                            paintData.updateImageSize();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: MyColors.lightGrey,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Text('Image preview',
                            style: TextStyle(
                                fontFamily: 'cocogoose', fontSize: 20)),
                      ],
                    ),
                  ),
                  paintData.getImage(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MyButton(
                          text: 'Select image',
                          onTap: () => paintData.setImage()),
                      MyButton(text: 'Add', onTap: () => paintData.addImage()),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MyButton(
                  text: 'Back',
                  onTap: () {
                    pop(paintData);
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
      ),
    );
  }

  Future<bool> onWillPop(PaintData paintData) async {
    pop(paintData);
    return false;
  }

  pop(PaintData paintData) {
    paintData.currentPage = PaintData.pages[0];
    paintData.currentTool = Tool.none;
  }

  editText(BuildContext context, PaintData paintData) {
    String text = paintData.text;
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Edit text'),
        content: TextField(
          decoration: InputDecoration(hintText: paintData.text),
          onChanged: (newText) {
            text = newText;
          },
        ),
        actions: <Widget>[
          MyButton(
            text: 'Ok',
            onTap: () {
              paintData.text = text;
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  selectColor(BuildContext context, PaintData paintData) {
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
