import 'package:injectable/injectable.dart';
import '../../repository/auth_repository.dart';

@Injectable()
class LoginUseCase {
  AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  launch({required String email, required String password}) => _authRepository.login(email: email, password: password);

}
