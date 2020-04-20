import 'package:flitro/templates/face_paint_template/tool_box/pages/brush_page.dart';
import 'package:flitro/utils/colors.dart';
import 'package:flutter/material.dart';

class ToolSelectorPage extends StatelessWidget {
  final Function changeTool;

  //const ToolSelector({Key key, this.changeTool}) : super(key: key);
  ToolSelectorPage(this.changeTool);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Select a tool',
            style: TextStyle(fontFamily: 'cocogoose', fontSize: 20),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ToolButton(icon: Icons.brush, onTap: () => changeTool(BrushPage())),
            ToolButton(icon: Icons.text_fields, onTap: null),
          ],
        )
      ],
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
