import 'package:paw_rescue/src/domain/use_cases/auth/login_usecase.dart';
import 'package:paw_rescue/src/domain/use_cases/auth/logout_usecase.dart';
import 'package:paw_rescue/src/domain/use_cases/auth/register_usecase.dart';
import 'package:paw_rescue/src/domain/use_cases/auth/user_session_usecase.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AuthUseCases {
  LoginUseCase login;
  RegisterUseCase register;
  UserSessionUseCase getUser;
  LogoutUseCase logout;

  AuthUseCases(
      {required this.login, required this.register, required this.getUser, required this.logout});
}
