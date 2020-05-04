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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 32),
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
            ToolButton(icon: Icons.text_fields, onTap: null),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 48),
          child: Container(
            decoration: BoxDecoration(
                color: MyColors.black, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Next',
                style: TextStyle(
                    fontFamily: 'cocogoose',
                    fontSize: 15,
                    color: MyColors.white),
              ),
            ),
          ),
        ),
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
