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
          if (paintData.currentTool == Tool.draw)
            paintData.addPoint(details, context);

          if (paintData.currentTool == Tool.text)
            paintData.moveText(details, context);
        },
        onPanEnd: (DragEndDetails details) {
          if (paintData.currentTool == Tool.draw) paintData.stopLine();
        },
        onTapDown: (TapDownDetails details) {
          if (paintData.currentTool == Tool.text)
            paintData.selectMovingText(details, context);
        },
        child: CustomPaint(
          painter: Painter(
            points: paintData.points,
            paths: paintData.paths,
            texts: paintData.texts,
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
  List<PaintText> texts;

  Painter({this.points, this.paths, this.texts});

  @override
  void paint(Canvas canvas, Size size) {
    //paths
    for (var path in paths) canvas.drawPath(path.path, path.paint);

    //points
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(
            points[i].offset, points[i + 1].offset, points[i].paint);
    }

    //texts
    for (var text in texts) {
      TextSpan span = TextSpan(
          text: text.text,
          style: TextStyle(
              fontFamily: text.font, color: text.color, fontSize: text.size));
      TextPainter textPainter = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      textPainter.layout();
      textPainter.paint(canvas, text.offset);
    }
  }

  @override
  bool shouldRepaint(Painter oldPainter) => true;
}
