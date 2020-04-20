import 'package:flitro/templates/face_paint_template/tool_box/pages/tool_selector_page.dart';
import 'package:flutter/material.dart';

class PaintingSpace extends StatefulWidget {
  PaintingSpace({Key key}) : super(key: key);

  @override
  _PaintingSpaceState createState() => _PaintingSpaceState();
}

class _PaintingSpaceState extends State<PaintingSpace> {
  List<PaintPoint> points = <PaintPoint>[];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 400,
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          if (SelectedTool.selectedTool == Tool.brush) {
            setState(() {
              RenderBox object = context.findRenderObject();
              Offset localPosition =
                  object.globalToLocal(details.globalPosition);
              points = new List.from(points);

              Paint paint = new Paint()
                ..color = BrushValues.color
                ..strokeCap = StrokeCap.round
                ..strokeWidth = BrushValues.thickness;

              points.add(new PaintPoint(localPosition, paint));
            });
          }
        },
        onPanEnd: (DragEndDetails details) => points.add(null),
        child: CustomPaint(
          painter: Painter(
            points: points,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class Painter extends CustomPainter {
  List<PaintPoint> points;

  Painter({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        if (points[i].offset.dx < 400 &&
            points[i].offset.dy < 400 &&
            points[i + 1].offset.dx < 400 &&
            points[i + 1].offset.dy < 400)
          canvas.drawLine(
              points[i].offset, points[i + 1].offset, points[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(Painter oldPainter) => oldPainter.points != points;
}

class PaintPoint {
  Offset offset;
  Paint paint;

  PaintPoint(this.offset, this.paint);
}

class BrushValues {
  static double thickness = 10.0;
  static Color color = Colors.black;
}
