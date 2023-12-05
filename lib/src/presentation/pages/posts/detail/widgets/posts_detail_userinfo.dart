import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paw_rescue/src/domain/models/user_data.dart';

class PostsDetailUserInfo extends StatelessWidget {
  UserData userData;

  PostsDetailUserInfo(this.userData);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            margin: const EdgeInsets.only(left: 20),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: userData.image.isNotEmpty
                  ? NetworkImage(userData.image)
                  : const AssetImage('assets/img/user_image.png')
                      as ImageProvider,
            )),
        Container(
          margin: const EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(userData.username,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              Text(
                userData.email,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }
}
