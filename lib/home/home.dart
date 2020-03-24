import 'package:flitro/utils/colors.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Title(),
          SubTitle(),
          Expanded(
            child: Center(
              child: BeginButton(),
            ),
          ),
        ],
      ),
    );
  }
}

class Title extends StatefulWidget {
  Title({Key key}) : super(key: key);

  @override
  _TitleState createState() => _TitleState();
}

class _TitleState extends State<Title> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offsetAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..forward();
    offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offsetAnimation,
      child: Padding(
        padding: EdgeInsets.only(top: 150),
        child: Text(
          'Filtro',
          style: TextStyle(
              fontFamily: 'Cocogoose', fontSize: 65, color: MyColors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class SubTitle extends StatefulWidget {
  SubTitle({Key key}) : super(key: key);

  @override
  _SubTitleState createState() => _SubTitleState();
}

class _SubTitleState extends State<SubTitle>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offsetAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..forward();
    offsetAnimation = Tween<Offset>(
      begin: Offset(1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offsetAnimation,
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text(
          'The Instagram effect creator',
          style: TextStyle(
              fontFamily: 'Cocogoose', fontSize: 20, color: MyColors.red),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class BeginButton extends StatelessWidget {
  const BeginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(top: 200),
        decoration: BoxDecoration(
          color: MyColors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Tap to begin',
          style: TextStyle(
              fontFamily: 'cocogoose', color: MyColors.white, fontSize: 20),
        ),
      ),
    );
  }
}
