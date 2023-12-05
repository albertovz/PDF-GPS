import 'package:paw_rescue/src/domain/repository/posts_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class DeleteLikePostUseCase {

  PostsRepository _repository;

  DeleteLikePostUseCase(this._repository);

  launch(String idPost, String idUser) => _repository.deleteLike(idPost, idUser);

}