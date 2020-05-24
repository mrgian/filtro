import 'package:flitro/templates/face_paint_template/button.dart';
import 'package:flitro/templates/face_paint_template/paint_data.dart';
import 'package:flitro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToolSelectorPage extends StatelessWidget {
  const ToolSelectorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paintData = Provider.of<PaintData>(context);
    paintData.currentTool = Tool.none;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 32),
            child: Text(
              'Select a tool',
              style: TextStyle(fontFamily: 'cocogoose', fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ToolButton(
                icon: Icons.brush,
                onTap: () => paintData.currentPage = PaintData.pages[1],
              ),
              ToolButton(
                  icon: Icons.text_fields,
                  onTap: () => paintData.currentPage = PaintData.pages[2]),
              ToolButton(
                  icon: Icons.image,
                  onTap: () => paintData.currentPage = PaintData.pages[3]),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: MyButton(text: 'Next', onTap: null),
          ),
        ],
      ),
    );
  }
}

class ToolButton extends StatelessWidget {
  final IconData icon;
  final Function onTap;

  const ToolButton({Key key, this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: RawMaterialButton(
        onPressed: onTap,
        child: Icon(
          icon,
          color: MyColors.white,
          size: 35.0,
        ),
        shape: CircleBorder(),
        elevation: 2.0,
        fillColor: MyColors.black,
        padding: EdgeInsets.all(15.0),
      ),
    );
  }
}
