import 'package:paw_rescue/src/domain/models/user_data.dart';
import 'package:paw_rescue/src/domain/repository/users_repository.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetUserById {

  UsersRepository _repository;

  GetUserById(this._repository);

  Stream <Resource<UserData>>launch(String id) => _repository.getUserById(id);

}