import 'package:flutter/material.dart';
import 'package:paw_rescue/src/presentation/utils/base_color.dart';

class DefaultButton extends StatelessWidget {
  String text;
  IconData icon;
  Color color;
  Function() onPressed;

  DefaultButton(
      {required this.text,
      required this.onPressed,
      this.icon = Icons.arrow_forward_ios,
      this.color = BASE_COLOR
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        child: Stack(
          children: [
            Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 17, color: Colors.black),
                )),
            Container(
              height: 50,
              alignment: Alignment.centerRight,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.black,
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ));
  }
}
