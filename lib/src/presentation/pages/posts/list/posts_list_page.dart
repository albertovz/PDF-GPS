import 'package:flutter/material.dart';
import 'package:paw_rescue/src/domain/models/post.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';
import 'package:paw_rescue/src/presentation/pages/posts/list/posts_list_event.dart';
import 'package:paw_rescue/src/presentation/pages/posts/list/widgets/posts_list_item.dart';
import 'package:paw_rescue/src/presentation/utils/base_color.dart';
import 'package:provider/provider.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    PostsListEvent vm = Provider.of<PostsListEvent>(context);

    return Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        body: StreamBuilder(
            stream: vm.getPosts(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                    child: Text(
                  'No hay información',
                  style: TextStyle(color: Colors.white),
                ));
              }
              final response = snapshot.data;
              if (response is Error) {
                final data = response as Error;
                return Center(
                  child: Text('Error: ${data.error}'),
                );
              }
              final postList = response as Success<List<Post>>;
              return ListView.builder(
                itemBuilder: (context, index) =>
                    PostsListItem(vm, postList.data[index]),
                itemCount: postList.data.length,
              );
            })));
  }
}
