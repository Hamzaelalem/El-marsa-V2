import 'package:el_marsa/helper/dimensions.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class ViewAllButton extends StatelessWidget {
  late final String text;
  late final double fontSize;
  late final FontWeight fontWeight;
  final Color borderColor;
  final double? borderWidth;
  late final double padding;
  late final Color hoverColor;
  final GestureTapCallback? onPress;

  ViewAllButton({
    super.key,
    this.text = "VIEW ALL",
    this.fontSize = 13,
    this.fontWeight = FontWeight.bold,
    this.borderColor = const Color.fromARGB(255, 2, 62, 115),
    this.borderWidth = 2,
    this.padding = 4,
    this.hoverColor = Colors.grey,
    required this.onPress, // Set desired hover color
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: borderColor, width: 1.5)),
        padding: EdgeInsets.all(Dimensions.screenWidth / 180),
        child: CustomeText(
          text: "VIEW ALL",
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: borderColor,
        ),
      ),
    );
  }
}



//   @override
//   Widget build(BuildContext context) {
//     return const TextButtonTheme(
//       onPressed: () {
//         // Add onPressed functionality
//       },
      // hoverColor: hoverColor,
      // shape: RoundedRectangleBorder(
      //   side: BorderSide(
      //     color: borderColor,
      //     width: borderWidth,
      //   ),
      //   borderRadius: BorderRadius.circular(0),
      // ),
//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: fontSize,
//           fontWeight: fontWeight,
//           color: borderColor,
//         ),
//       ),
//     );
//   }
// }



