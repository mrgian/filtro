import 'package:flitro/templates/face_paint_template/painting_space.dart';
import 'package:flitro/templates/face_paint_template/tool_box/pages/tool_selector_page.dart';
import 'package:flitro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class BrushPage extends StatefulWidget {
  final Function changeTool;

  BrushPage(this.changeTool);

  @override
  _BrushPageState createState() => _BrushPageState();
}

class _BrushPageState extends State<BrushPage> {
  Color pickerColor = BrushValues.color;

  @override
  Widget build(BuildContext context) {
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
                    width: BrushValues.thickness,
                    height: BrushValues.thickness,
                    decoration: new BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                  ),
                ),
              ),
              Expanded(
                child: Slider(
                  activeColor: MyColors.black,
                  inactiveColor: MyColors.darkGrey,
                  value: BrushValues.thickness,
                  min: 1.0,
                  max: 20.0,
                  onChanged: (t) {
                    setState(() {
                      BrushValues.thickness = t;
                    });
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
                        color: BrushValues.color, shape: BoxShape.circle),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: GestureDetector(
                  onTap: () => selectColor(),
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
                widget.changeTool(ToolSelectorPage(widget.changeTool));
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

  selectColor() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: (color) {
              setState(() {
                pickerColor = color;
              });
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
              setState(() => BrushValues.color = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
