import 'package:flutter/material.dart';
import 'package:paw_rescue/src/presentation/pages/posts/create/post_create_event.dart';
import 'package:paw_rescue/src/presentation/pages/posts/create/posts_create_response.dart';
import 'package:paw_rescue/src/presentation/pages/posts/create/widgets/posts_create_content.dart';
import 'package:paw_rescue/src/presentation/utils/base_color.dart';
import 'package:provider/provider.dart';

class PostsCreatePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    PostsCreateEvent vm = Provider.of<PostsCreateEvent>(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PostsCreateResponse(context, vm);
    });

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: PostsCreateContent(vm),
    );
  }
}