import 'package:firebase_auth/firebase_auth.dart';
import 'package:paw_rescue/src/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class UserSessionUseCase {

  AuthRepository _repository;

  UserSessionUseCase(this._repository);

  User? get userSession => this._repository.user;

}