import 'package:flitro/templates/face_paint_template/face_paint_template.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TemplateCard extends StatelessWidget {
  final String name;
  final String description;
  final String image;

  const TemplateCard({Key key, this.name, this.description, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: MyColors.lightGrey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: <Widget>[
            Image.asset(image, width: 70, height: 70),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                    child: Text(name,
                        style:
                            TextStyle(fontFamily: 'cocogoose', fontSize: 15)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Text(description),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        switch (name) {
          case 'Face paint':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FacePaintTemplate()),
            );
            break;
          default:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FacePaintTemplate()),
            );
        }
      },
    );
  }
}
