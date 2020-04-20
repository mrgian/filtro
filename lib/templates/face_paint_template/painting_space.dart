import 'package:flutter/material.dart';

class PaintingSpace extends StatefulWidget {
  PaintingSpace({Key key}) : super(key: key);

  @override
  _PaintingSpaceState createState() => _PaintingSpaceState();
}

class _PaintingSpaceState extends State<PaintingSpace> {
  List<Offset> points = <Offset>[];
  Color color = Colors.black;
  StrokeCap strokeCap = StrokeCap.round;
  double strokeWidth = 5.0;
  List<Painter> painters = <Painter>[];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 400,
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            RenderBox object = context.findRenderObject();
            Offset localPosition = object.globalToLocal(details.globalPosition);
            points = new List.from(points);
            points.add(localPosition);
          });
        },
        onPanEnd: (DragEndDetails details) => points.add(null),
        child: CustomPaint(
          painter: Painter(
              points: points,
              color: color,
              strokeCap: strokeCap,
              strokeWidth: strokeWidth,
              painters: painters),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class Painter extends CustomPainter {
  List<Offset> points;
  Color color;
  StrokeCap strokeCap;
  double strokeWidth;
  List<Painter> painters;

  Painter(
      {this.points,
      this.color,
      this.strokeCap,
      this.strokeWidth,
      this.painters = const []});

  @override
  void paint(Canvas canvas, Size size) {
    for (Painter painter in painters) {
      painter.paint(canvas, size);
    }

    Paint paint = new Paint();
    paint.color = color;
    paint.strokeCap = strokeCap;
    paint.strokeWidth = strokeWidth;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        if (points[i].dx < 400 &&
            points[i].dy < 400 &&
            points[i + 1].dx < 400 &&
            points[i + 1].dy < 400)
          canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Painter oldPainter) => oldPainter.points != points;
}
