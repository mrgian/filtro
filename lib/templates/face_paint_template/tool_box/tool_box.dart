import 'package:flitro/templates/face_paint_template/tool_box/pages/tool_selector_page.dart';
import 'package:flutter/material.dart';

class ToolBox extends StatefulWidget {
  ToolBox({Key key}) : super(key: key);

  @override
  _ToolBoxState createState() => _ToolBoxState();
}

class _ToolBoxState extends State<ToolBox> {
  Widget currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = ToolSelectorPage(changeTool);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: currentPage,
    );
  }

  changeTool(Widget newPage) {
    setState(() {
      currentPage = newPage;
    });
  }
}
