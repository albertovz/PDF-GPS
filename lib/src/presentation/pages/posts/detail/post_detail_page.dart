import 'package:flutter/material.dart';
import 'package:paw_rescue/src/domain/models/post.dart';
import 'package:paw_rescue/src/presentation/pages/posts/detail/posts_detail_event.dart';
import 'package:paw_rescue/src/presentation/pages/posts/detail/widgets/posts_detail_content.dart';
import 'package:paw_rescue/src/presentation/utils/base_color.dart';
import 'package:provider/provider.dart';

class PostsDetailPage extends StatelessWidget {
  PostsDetailPage();

  @override
  Widget build(BuildContext context) {
    PostsDetailEvent vm = Provider.of<PostsDetailEvent>(context);
    Post postArg = ModalRoute.of(context)?.settings.arguments as Post;
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: PostsDetailContent(vm, postArg));
  }
}
