import 'package:flitro/templates/face_paint_template/paint_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaintingSpace extends StatelessWidget {
  const PaintingSpace({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paintData = Provider.of<PaintData>(context);
    return SizedBox(
      width: 400,
      height: 400,
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          paintData.addPoint(details, context);
        },
        onPanEnd: (DragEndDetails details) {
          paintData.stopLine();
        },
        child: CustomPaint(
          painter: Painter(
            points: paintData.points,
            paths: paintData.paths,
          ),
          size: Size.infinite,
        ),
      ),
    );
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
  }

  @override
  bool shouldRepaint(Painter oldPainter) => oldPainter.points != points;
}
