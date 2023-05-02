import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../constance.dart';
import 'custom_text.dart';

class CustomFormButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;

  const CustomFormButton({
    this.text,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: CustomeText(
        text: text,
        color: Colors.white,
        alignment: Alignment.center,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: padding,
      ),
    );
  }
}
