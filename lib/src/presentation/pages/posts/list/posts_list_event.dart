import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:paw_rescue/src/domain/models/post.dart';
import 'package:paw_rescue/src/domain/models/user_data.dart';
import 'package:paw_rescue/src/domain/use_cases/auth/auth_usecases.dart';
import 'package:paw_rescue/src/domain/use_cases/posts/posts_usecases.dart';
import 'package:paw_rescue/src/domain/use_cases/users/users_usecases.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';

class PostsListEvent extends ChangeNotifier {
  PostsUseCases _postsUseCases;
  AuthUseCases _authUseCases;
  UsersUseCase _usersUseCase;
  String _id = '';
  String get id => _id;

  PostsListEvent(this._authUseCases, this._postsUseCases, this._usersUseCase) {
    _id = _authUseCases.getUser.userSession?.uid ?? '';
  }

  Stream<Resource<List<Post>>> getPosts() => _postsUseCases.getPosts.launch();

  Future<UserData> getUserInfo (String idUser) => _usersUseCase.getUserByIdOnce.launch(idUser);

  like(String idPost) async {
    await _postsUseCases.like.launch(idPost, id);
  }

  deleteLike(String idPost) async {
    await _postsUseCases.deleteLike.launch(idPost, id);
  }

}
