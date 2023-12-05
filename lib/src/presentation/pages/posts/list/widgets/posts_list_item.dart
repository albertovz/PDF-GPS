import 'package:audioplayers/audioplayers.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:paw_rescue/src/domain/models/post.dart';
import 'package:paw_rescue/src/presentation/pages/posts/list/posts_list_event.dart';
import 'package:paw_rescue/src/presentation/pages/posts/list/widgets/post_list_userinfo.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:video_player/video_player.dart';

class PostsListItem extends StatelessWidget {
  Post post;
  PostsListEvent vm;

  PostsListItem(this.vm, this.post);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'posts/detail', arguments: post);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        child: Card(
          color: Colors.white12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              post.contentType == 'photo'
                  ? Container(
                      child: Image(
                        image: NetworkImage(post.image),
                        width: double.infinity,
                        height: 450,
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
              // Container(
              //     height: 450,
              //     child: PDFView(
              //       filePath: post
              //           .image, // Asegúrate de que post.image sea la ruta del archivo PDF
              //       enableSwipe: true,
              //       swipeHorizontal: true,
              //       autoSpacing: false,
              //       pageFling: false,
              //       pageSnap: false,
              //       defaultPage: 1,
              //       fitPolicy: FitPolicy.WIDTH,
              //     ),
              //   ),

              //
              Row(
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
                      PostListUserInfo(vm, post.idUser),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(post.description,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white)),
                      ),
                    ],
                  ),
                  const Spacer(),
                  post.likes.contains(vm.id)
                      ? GestureDetector(
                          onTap: () {
                            vm.deleteLike(post.id);
                          },
                          child: Image.asset(
                            'assets/img/like.png',
                            width: 30,
                            height: 30,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            vm.like(post.id);
                          },
                          child: Image.asset(
                            'assets/img/like_outline.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                  Container(
                    margin: const EdgeInsets.only(right: 20, left: 10),
                    child: Text(
                      post.likes.length.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 19),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
