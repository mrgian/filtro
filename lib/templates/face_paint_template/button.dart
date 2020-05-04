import 'package:flitro/utils/colors.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function onTap;
  final String text;

  const MyButton({Key key, this.onTap, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
              color: MyColors.black, borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              text,
              style: TextStyle(
                  fontFamily: 'cocogoose', fontSize: 15, color: MyColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
