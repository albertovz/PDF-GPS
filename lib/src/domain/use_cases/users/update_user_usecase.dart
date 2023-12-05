import 'package:paw_rescue/src/domain/models/user_data.dart';
import 'package:paw_rescue/src/domain/repository/users_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class UpdateUserUseCase {

  UsersRepository _repository;

  UpdateUserUseCase(this._repository);

  launch(UserData userData) => _repository.updateWithoutImage(userData);

}