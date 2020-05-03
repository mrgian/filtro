import 'package:flitro/templates/face_paint_template/tools/brush_page.dart';
import 'package:flitro/templates/face_paint_template/tools/tool_selector_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Tool { none, draw, text }

class PaintData with ChangeNotifier {
  //Points
  List<PaintPoint> _points = <PaintPoint>[];
  get points => _points;

  addPoint(DragUpdateDetails details, BuildContext context) {
    RenderBox object = context.findRenderObject();
    Offset localPosition = object.globalToLocal(details.globalPosition);
    _points = new List.from(points);

    Paint paint = new Paint()
      ..color = _color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    if (localPosition.dx < 400 && localPosition.dy < 400)
      points.add(new PaintPoint(localPosition, paint));

    notifyListeners();
  }

  //Paths
  List<PaintPath> _paths = <PaintPath>[];
  get paths => _paths;

  stopLine() {
    Path path = new Path();
    for (int i = 0; i < points.length; i++) {
      if (i == 0)
        path.moveTo(points[i].offset.dx, points[i].offset.dy);
      else
        path.lineTo(points[i].offset.dx, points[i].offset.dy);
    }

    Paint paint = new Paint()
      ..color = _color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    paths.add(new PaintPath(path, paint));
    _points = <PaintPoint>[];

    notifyListeners();
  }

  //Thickness
  double _thickness = 10.0;
  get thickness => _thickness;
  set thickness(double newValue) {
    _thickness = newValue;
    notifyListeners();
  }

  //Color
  Color _color = Colors.black;
  get color => _color;
  set color(Color newColor) {
    _color = newColor;
    notifyListeners();
  }

  //Page
  static List<Widget> pages = <Widget>[ToolSelectorPage(), BrushPage()];
  Widget _currentPage = pages.first;
  get currentPage => _currentPage;
  set currentPage(Widget newPage) {
    _currentPage = newPage;
    notifyListeners();
  }

  //Tool
  Tool _currentTool = Tool.none;
  get currentTool => _currentTool;
  set currentTool(Tool newTool) {
    _currentTool = newTool;
    notifyListeners();
  }
}

class PaintPoint {
  Offset offset;
  Paint paint;

  PaintPoint(this.offset, this.paint);
}

class PaintPath {
  Path path;
  Paint paint;

  PaintPath(this.path, this.paint);
}
