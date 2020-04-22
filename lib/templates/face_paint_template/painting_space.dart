import 'package:flitro/templates/face_paint_template/tool_box/pages/tool_selector_page.dart';
import 'package:flutter/material.dart';

class PaintingSpace extends StatefulWidget {
  PaintingSpace({Key key}) : super(key: key);

  @override
  _PaintingSpaceState createState() => _PaintingSpaceState();
}

class _PaintingSpaceState extends State<PaintingSpace> {
  List<PaintPoint> points = <PaintPoint>[];
  List<PaintPath> paths = <PaintPath>[];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 400,
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          if (SelectedTool.selectedTool == Tool.brush) {
            setState(() {
              addPoint(details);
            });
          }
        },
        onPanEnd: (DragEndDetails details) {
          setState(() {
            stopLine();
          });
        },
        child: CustomPaint(
          painter: Painter(
            points: points,
            paths: paths,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }

  addPoint(DragUpdateDetails details) {
    RenderBox object = context.findRenderObject();
    Offset localPosition = object.globalToLocal(details.globalPosition);
    points = new List.from(points);

    Paint paint = new Paint()
      ..color = BrushValues.color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = BrushValues.thickness;

    if (localPosition.dx < 400 && localPosition.dy < 400)
      points.add(new PaintPoint(localPosition, paint));
  }

  stopLine() {
    Path path = new Path();
    for (int i = 0; i < points.length; i++) {
      if (i == 0)
        path.moveTo(points[i].offset.dx, points[i].offset.dy);
      else
        path.lineTo(points[i].offset.dx, points[i].offset.dy);
    }

    Paint paint = new Paint()
      ..color = BrushValues.color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = BrushValues.thickness;
    paths.add(new PaintPath(path, paint));
    points = <PaintPoint>[];
  }
}

class Painter extends CustomPainter {
  List<PaintPoint> points;
  List<PaintPath> paths;

  Painter({this.points, this.paths});

  @override
  void paint(Canvas canvas, Size size) {
    for (var path in paths) canvas.drawPath(path.path, path.paint);

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(
            points[i].offset, points[i + 1].offset, points[i].paint);
    }

    /*TextSpan span =
        new TextSpan(style: new TextStyle(color: Colors.white), text: 'Greve');
    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.left);
    tp.layout();
    tp.paint(canvas, new Offset(5.0, 5.0));*/
  }

  @override
  bool shouldRepaint(Painter oldPainter) => oldPainter.points != points;
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

class BrushValues {
  static double thickness = 10.0;
  static Color color = Colors.black;
}
