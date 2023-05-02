import 'package:el_marsa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../constance.dart';

class CustomFormField extends StatelessWidget {
  final String? text;

  final String? hint;

  final void Function(String?)? onSave;
  final String? Function(String?)? validator;

  const CustomFormField(
      {super.key,
      this.text,
      this.hint = 'exemple@yahou.com',
      this.onSave,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomeText(
            text: text,
            fontSize: 14,
            color: Colors.grey.shade900,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              fillColor: Colors.white,
            ),
            validator: validator,
            onSaved: onSave,
          )
        ],
      ),
    );
  }
}
