import 'dart:io';

import 'package:paw_rescue/src/domain/models/post.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';

abstract class PostsRepository {

  Future<Resource<String>> create(Post post, File image);
  Future<Resource<String>> delete(String idPost);
  Future<Resource<String>> update(Post post);
  Future<Resource<String>> updateWithImage(Post post, File image);
  Future<Resource<bool>> like(String idPost, String idUser);
  Future<Resource<bool>> deleteLike(String idPost, String idUser);
  Stream<Resource<List<Post>>> getPosts();
  Stream<Resource<List<Post>>> getPostsById(String id);

}