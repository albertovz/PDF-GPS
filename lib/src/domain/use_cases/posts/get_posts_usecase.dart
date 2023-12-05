import 'package:paw_rescue/src/domain/models/post.dart';
import 'package:paw_rescue/src/domain/repository/posts_repository.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetPostsUseCase {

  PostsRepository _repository;

  GetPostsUseCase(this._repository);

  Stream<Resource<List<Post>>> launch() => _repository.getPosts();

}