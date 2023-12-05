import 'package:flutter/foundation.dart';
import 'package:paw_rescue/src/domain/models/user_data.dart';
import 'package:paw_rescue/src/domain/use_cases/posts/posts_usecases.dart';
import 'package:paw_rescue/src/domain/use_cases/users/users_usecases.dart';

class PostsDetailEvent extends ChangeNotifier {

  PostsUseCases _postsUseCases;
  UsersUseCase _usersUseCase;

  PostsDetailEvent(this._postsUseCases, this._usersUseCase);

  Future<UserData> getUser(String id) => _usersUseCase.getUserByIdOnce.launch(id);

}