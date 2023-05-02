import 'package:flutter/material.dart';

class ProfileRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function()? onpressed;

  const ProfileRow({
    Key? key,
    required this.icon,
    required this.text,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Color.fromARGB(255, 241, 241, 241), // Change color here
      ),
      child: Container(
        // color: Colors.amber,
        height: 60,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            SizedBox(width: 25),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
