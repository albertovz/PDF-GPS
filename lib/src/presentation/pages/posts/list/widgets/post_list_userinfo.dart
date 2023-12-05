import 'package:flutter/material.dart';
import 'package:paw_rescue/src/presentation/pages/posts/list/posts_list_event.dart';

class PostListUserInfo extends StatelessWidget {
  PostsListEvent vm;
  String idUser;
  PostListUserInfo(this.vm, this.idUser);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: vm.getUserInfo(idUser),
        builder: (context, data) {
          final user = data.data;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(user?.username ?? '',
                style: const TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 179, 176, 176))),
          );
        });
  }
}
