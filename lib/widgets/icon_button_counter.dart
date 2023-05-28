import 'package:el_marsa/helper/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'custom_text.dart';

class IconButtonCounter extends StatelessWidget {
  final IconData? icon;
  final int? numOfItem;
  final GestureTapCallback? press;

  const IconButtonCounter(
      {this.icon, this.numOfItem = 0, @required this.press});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(15),
      // highlightColor: Colors.blue,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
              // paddin = 9 causing error makit responsive
              padding: EdgeInsets.all(Dimensions.font10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 240, 241, 241)),
              child: Center(
                  child: Icon(
                icon,
                color: Colors.black,
              ))),
          numOfItem! > 0
              ? Container(
                  height: 15,
                  width: 15,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  child: Center(
                      child: CustomeText(
                    text: "$numOfItem",
                    fontSize: 10,
                    alignment: Alignment.center,
                    color: Colors.white,
                  )),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
