import 'package:flutter/material.dart';

class FacePaintTemplate extends StatelessWidget {
  const FacePaintTemplate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Editor', style: TextStyle(fontFamily: 'cocogoose')),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
                child: Stack(
              children: <Widget>[
                Image.asset('assets/images/faceMasculine.jpg',
                    width: 400, height: 400),
                PaintingSpace(),
              ],
            )),
          ],
        ));
  }
}

class PaintingSpace extends StatefulWidget {
  PaintingSpace({Key key}) : super(key: key);

  @override
  _PaintingSpaceState createState() => _PaintingSpaceState();
}

class _PaintingSpaceState extends State<PaintingSpace> {
  List<Offset> points = List();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        height: 400,
        width: 400,
        child: CustomPaint(
          painter: MyPainter(points: points),
        ),
      ),
      onPanUpdate: (details) {
        setState(() {
          points.add(details.localPosition);
        });
      },
    );
  }
}

class MyPainter extends CustomPainter {
  List<Offset> points = List();

  MyPainter({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    for (var point in points) {
      if (point.dx <= 400 && point.dy <= 400)
        canvas.drawCircle(point, 5, Paint()..color = Colors.black);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
