import 'package:flutter/material.dart';
import 'package:paw_rescue/src/presentation/utils/base_color.dart';

class PostsCategory extends StatelessWidget {
  String value;
  String groupValue;
  Function(String value) onChanged;
  String imagePath;

  PostsCategory(
      {required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, top: 10),
      child: Row(
        children: [
          Radio(
              value: value,
              groupValue: groupValue,
              activeColor: BASE_COLOR,
              onChanged: (value) {
                onChanged(value ?? '');
              }),
          Container(
            width: 130,
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 25),
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
              ))
        ],
      ),
    );
  }
}
