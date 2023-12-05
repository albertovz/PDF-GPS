import 'dart:io';

import 'package:paw_rescue/src/domain/models/user_data.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';

abstract class UsersRepository {
  Stream<Resource<UserData>> getUserById(String id);
  Future<UserData> getUserByIdOnce (String id);
  Future<Resource<String>> updateWithoutImage(UserData userData);
  Future<Resource<String>> updateWithImage(UserData userData, File image);
}
