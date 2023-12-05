import 'package:flutter/material.dart';
import 'package:paw_rescue/src/domain/models/post.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';
import 'package:paw_rescue/src/presentation/pages/posts/my_list/posts_mylist_event.dart';
import 'package:paw_rescue/src/presentation/pages/posts/my_list/widgets/posts_my_list_item.dart';
import 'package:paw_rescue/src/presentation/utils/base_color.dart';
import 'package:provider/provider.dart';

class PostsMyListPage extends StatelessWidget {
  const PostsMyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    PostsMyListEvent vm = Provider.of<PostsMyListEvent>(context);

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: StreamBuilder(
          stream: vm.getPostsById(),
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
                  PostsMyListItem(vm, postList.data[index]),
              itemCount: postList.data.length,
            );
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'posts/create');
        },
        backgroundColor: BASE_COLOR,
        child: const Icon(Icons.add),
      ),
    );
  }
}
