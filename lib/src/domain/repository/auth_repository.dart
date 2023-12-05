import 'package:firebase_auth/firebase_auth.dart';
import 'package:paw_rescue/src/domain/models/user_data.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';

abstract class AuthRepository {

  User? get user;
  Future<Resource> login ({required String email, required String password});
  Future<Resource> register (UserData user);
  Future<void> logout();
}