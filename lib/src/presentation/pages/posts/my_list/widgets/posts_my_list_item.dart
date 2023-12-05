import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:paw_rescue/src/domain/models/post.dart';
import 'package:paw_rescue/src/presentation/pages/posts/my_list/posts_mylist_event.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:video_player/video_player.dart';

class PostsMyListItem extends StatelessWidget {
  Post post;
  PostsMyListEvent vm;

  PostsMyListItem(this.vm, this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: Card(
        color: Colors.white12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image(
            //   image: NetworkImage(post.image),
            //   width: double.infinity,
            //   height: 250,
            //   fit: BoxFit.cover,
            // ),
            post.contentType == 'photo'
                ? Container(
                    child: Image(
                      image: NetworkImage(post.image),
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  )
                : post.contentType == 'pdf'
                    ? Container(
                        height: 450,
                        child: SfPdfViewer.network(post.image),
                      )
                    : Container(
                        height: 250,
                        child: Chewie(
                          controller: ChewieController(
                            videoPlayerController:
                                VideoPlayerController.network(post.image),
                            aspectRatio: 16 / 9,
                            autoPlay: false,
                            looping: false,
                          ),
                        ),
                      ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(post.name,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(post.description,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'posts/update',
                              arguments: post);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {
                          vm.deletePost(post.id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
