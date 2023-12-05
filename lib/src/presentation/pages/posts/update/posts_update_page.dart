import 'package:flutter/material.dart';
import 'package:paw_rescue/src/domain/models/post.dart';
import 'package:paw_rescue/src/presentation/pages/posts/update/post_update_response.dart';
import 'package:paw_rescue/src/presentation/pages/posts/update/posts_update_event.dart';
import 'package:paw_rescue/src/presentation/pages/posts/update/widgets/posts_update_content.dart';
import 'package:paw_rescue/src/presentation/utils/base_color.dart';
import 'package:provider/provider.dart';

class PostsUpdatePage extends StatelessWidget {
  const PostsUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    PostsUpdateEvent vm = Provider.of<PostsUpdateEvent>(context);
    Post postArg = ModalRoute.of(context)?.settings.arguments as Post;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PostUpdateResponse(context, vm);
    });

    return Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        body: FutureBuilder(
            future: vm.loadData(postArg),
            builder: (context, _) => PostsUpdateContent(vm, postArg)));
  }
}
