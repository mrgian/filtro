import 'dart:io';
import 'dart:ui' as ui;

import 'package:flitro/templates/face_paint_template/tools/brush_page.dart';
import 'package:flitro/templates/face_paint_template/tools/image_page.dart';
import 'package:flitro/templates/face_paint_template/tools/text_page.dart';
import 'package:flitro/templates/face_paint_template/tools/tool_selector_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

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
      _points.add(new PaintPoint(localPosition, paint));

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

    _paths.add(new PaintPath(path, paint));
    _points = <PaintPoint>[];

    notifyListeners();
  }

  //Undo
  undo() {
    if (_paths.length > 0 && currentTool == Tool.draw) _paths.removeLast();
    if (_texts.length > 0 && currentTool == Tool.text) _texts.removeLast();
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
  static List<Widget> pages = <Widget>[
    ToolSelectorPage(),
    BrushPage(),
    TextPage(),
    ImagePage()
  ];
  Widget _currentPage = pages.first;
  get currentPage => _currentPage;
  set currentPage(Widget newPage) {
    _currentPage = newPage;
    notifyListeners();
  }

  //Tool
  Tool currentTool = Tool.none;

  //Text
  String _text = 'Edit me';
  get text => _text;
  set text(String newText) {
    _text = newText;
    notifyListeners();
  }

  //Text size
  double _textSize = 10;
  get textSize => _textSize;
  set textSize(double newValue) {
    _textSize = newValue;
    notifyListeners();
  }

  //Text color
  Color _textColor = Colors.red;
  get textColor => _textColor;
  set textColor(Color newColor) {
    _textColor = newColor;
    notifyListeners();
  }

  //Texts
  List<PaintText> _texts = <PaintText>[];
  get texts => _texts;

  addText() {
    _texts.add(
        new PaintText(text, textColor, new Offset(200, 200), textSize, font));
    notifyListeners();
  }

  //Move text
  int _selectedText = 0;

  moveText(DragUpdateDetails details, BuildContext context) {
    if (_texts.length != 0) {
      _texts[_selectedText].offset += details.delta;
      notifyListeners();
    }
  }

  selectMovingText(TapDownDetails details, BuildContext context) {
    //TODO Fix not in range exception
    _selectedText = 0;
    RenderBox object = context.findRenderObject();
    Offset localPosition = object.globalToLocal(details.globalPosition);
    if (_texts.length != 0) {
      for (int i = 0; i < _texts.length; i++) {
        double distance = (_texts[i].offset - localPosition).distance.abs();
        double minDistance =
            (_texts[_selectedText].offset - localPosition).distance.abs();
        if (distance < minDistance) _selectedText = i;
      }
    }
  }

  //fonts
  static List<String> fonts = <String>[
    'cocogoose',
    'longshot',
    'oldlondon',
    'chicken',
    'cherolina'
  ];

  String _font = fonts[1];
  get font => _font;
  set font(String newFont) {
    _font = newFont;
    notifyListeners();
  }

  //Image size
  double _imageSize = 100;
  get imageSize => _imageSize;
  set imageSize(double newValue) {
    _imageSize = newValue;
    notifyListeners();
  }

  //Image
  MyImage _image;
  File _imageFile;
  Widget getImage() {
    if (_image == null)
      return Container(width: 0, height: 0);
    else
      return _image;
  }

  setImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    _image = MyImage(image: Image.file(_imageFile, width: _imageSize));
    notifyListeners();
  }

  updateImageSize() {
    if (_imageFile != null)
      _image = MyImage(image: Image.file(_imageFile, width: _imageSize));
    notifyListeners();
  }

  List<PaintImage> _images = <PaintImage>[];
  get images => _images;

  Future<void> addImage() async {
    if (_image != null) {
      ui.Image iimage = await _image.getImage();
      _images.add(new PaintImage(iimage, Offset(0, 0)));
      notifyListeners();
    }
  }
}

class PaintText {
  Offset offset;
  String text;
  Color color;
  double size;
  String font;

  PaintText(this.text, this.color, this.offset, this.size, this.font);
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

class PaintImage {
  ui.Image image;
  Offset offset;

  PaintImage(this.image, this.offset);
}

class MyImage extends StatelessWidget {
  const MyImage({Key key, this.image}) : super(key: key);

  final Image image;
  static GlobalKey myKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: myKey,
      child: image,
    );
  }

  Future<ui.Image> getImage() async {
    RenderRepaintBoundary boundary = myKey.currentContext.findRenderObject();
    return await boundary.toImage();
  }
}
