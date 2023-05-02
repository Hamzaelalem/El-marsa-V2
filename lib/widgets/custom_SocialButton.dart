import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'custom_text.dart';

class SocialButton extends StatelessWidget {
  final String? text;
  final String? icon;
  final VoidCallback? onPressed;
  const SocialButton({this.text, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade100,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 32),
      ),
      child: Row(
        children: [
          Image.asset(
            icon!,
            height: 20,
            width: 20,
            // fit: BoxFit.fitWidth,
          ),
          SizedBox(
            width: 60,
          ),
          CustomeText(
            text: text,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
