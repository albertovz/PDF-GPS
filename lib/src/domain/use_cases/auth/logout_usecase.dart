import 'package:paw_rescue/src/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class LogoutUseCase {
  AuthRepository _repository;

  LogoutUseCase(this._repository);

  launch() => _repository.logout();
}
