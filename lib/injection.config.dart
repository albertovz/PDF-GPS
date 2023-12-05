// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i3;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:firebase_storage/firebase_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:paw_rescue/src/data/repository/auth_repository_impl.dart'
    as _i10;
import 'package:paw_rescue/src/data/repository/posts_repository_impl.dart'
    as _i16;
import 'package:paw_rescue/src/data/repository/users_repository_impl.dart'
    as _i8;
import 'package:paw_rescue/src/di/app_module.dart' as _i32;
import 'package:paw_rescue/src/di/firesebase_service.dart' as _i5;
import 'package:paw_rescue/src/domain/repository/auth_repository.dart' as _i9;
import 'package:paw_rescue/src/domain/repository/posts_repository.dart' as _i15;
import 'package:paw_rescue/src/domain/repository/users_repository.dart' as _i7;
import 'package:paw_rescue/src/domain/use_cases/auth/auth_usecases.dart'
    as _i24;
import 'package:paw_rescue/src/domain/use_cases/auth/login_usecase.dart'
    as _i13;
import 'package:paw_rescue/src/domain/use_cases/auth/logout_usecase.dart'
    as _i14;
import 'package:paw_rescue/src/domain/use_cases/auth/register_usecase.dart'
    as _i17;
import 'package:paw_rescue/src/domain/use_cases/auth/user_session_usecase.dart'
    as _i22;
import 'package:paw_rescue/src/domain/use_cases/posts/create_post_usecase.dart'
    as _i25;
import 'package:paw_rescue/src/domain/use_cases/posts/delete_like_post_usecase.dart'
    as _i26;
import 'package:paw_rescue/src/domain/use_cases/posts/delete_post_usecase.dart'
    as _i27;
import 'package:paw_rescue/src/domain/use_cases/posts/get_posts_by_id_usecase.dart'
    as _i28;
import 'package:paw_rescue/src/domain/use_cases/posts/get_posts_usecase.dart'
    as _i29;
import 'package:paw_rescue/src/domain/use_cases/posts/like_post_usecase.dart'
    as _i30;
import 'package:paw_rescue/src/domain/use_cases/posts/posts_usecases.dart'
    as _i31;
import 'package:paw_rescue/src/domain/use_cases/posts/update_post_image_usecase.dart'
    as _i18;
import 'package:paw_rescue/src/domain/use_cases/posts/update_post_usecase.dart'
    as _i19;
import 'package:paw_rescue/src/domain/use_cases/users/getUserById_usecase.dart'
    as _i11;
import 'package:paw_rescue/src/domain/use_cases/users/getuserbyidonce_usecase.dart'
    as _i12;
import 'package:paw_rescue/src/domain/use_cases/users/update_image_usecase.dart'
    as _i21;
import 'package:paw_rescue/src/domain/use_cases/users/update_user_usecase.dart'
    as _i20;
import 'package:paw_rescue/src/domain/use_cases/users/users_usecases.dart'
    as _i23;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i3.CollectionReference<Object?>>(
      () => appModule.usersRef,
      instanceName: 'Users',
    );
    gh.factory<_i3.CollectionReference<Object?>>(
      () => appModule.postsRef,
      instanceName: 'Posts',
    );
    gh.factory<_i4.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.factory<_i3.FirebaseFirestore>(() => appModule.firebaseFirestore);
    await gh.factoryAsync<_i5.FirebaseService>(
      () => appModule.fireebaseService,
      preResolve: true,
    );
    gh.factory<_i6.FirebaseStorage>(() => appModule.firebaseStorage);
    gh.factory<_i6.Reference>(
      () => appModule.usersStorageRef,
      instanceName: 'Users',
    );
    gh.factory<_i6.Reference>(
      () => appModule.postsStorageRef,
      instanceName: 'Posts',
    );
    gh.factory<_i7.UsersRepository>(() => _i8.UsersRepositoryImpl(
          gh<_i3.CollectionReference<Object?>>(instanceName: 'Users'),
          gh<_i6.Reference>(instanceName: 'Users'),
        ));
    gh.factory<_i9.AuthRepository>(() => _i10.AuthRepositoryImpl(
          gh<_i4.FirebaseAuth>(),
          gh<_i3.CollectionReference<Object?>>(instanceName: 'Users'),
        ));
    gh.factory<_i11.GetUserById>(
        () => _i11.GetUserById(gh<_i7.UsersRepository>()));
    gh.factory<_i12.GetUserByIdOnce>(
        () => _i12.GetUserByIdOnce(gh<_i7.UsersRepository>()));
    gh.factory<_i13.LoginUseCase>(
        () => _i13.LoginUseCase(gh<_i9.AuthRepository>()));
    gh.factory<_i14.LogoutUseCase>(
        () => _i14.LogoutUseCase(gh<_i9.AuthRepository>()));
    gh.factory<_i15.PostsRepository>(() => _i16.PostsRepositoryImpl(
          gh<_i3.CollectionReference<Object?>>(instanceName: 'Posts'),
          gh<_i6.Reference>(instanceName: 'Posts'),
        ));
    gh.factory<_i17.RegisterUseCase>(
        () => _i17.RegisterUseCase(gh<_i9.AuthRepository>()));
    gh.factory<_i18.UpdatePostImageUseCase>(
        () => _i18.UpdatePostImageUseCase(gh<_i15.PostsRepository>()));
    gh.factory<_i19.UpdatePostUseCase>(
        () => _i19.UpdatePostUseCase(gh<_i15.PostsRepository>()));
    gh.factory<_i20.UpdateUserUseCase>(
        () => _i20.UpdateUserUseCase(gh<_i7.UsersRepository>()));
    gh.factory<_i21.UpdateWithImageUseCase>(
        () => _i21.UpdateWithImageUseCase(gh<_i7.UsersRepository>()));
    gh.factory<_i22.UserSessionUseCase>(
        () => _i22.UserSessionUseCase(gh<_i9.AuthRepository>()));
    gh.factory<_i23.UsersUseCase>(() => _i23.UsersUseCase(
          getById: gh<_i11.GetUserById>(),
          getUserByIdOnce: gh<_i12.GetUserByIdOnce>(),
          updateWithoutImage: gh<_i20.UpdateUserUseCase>(),
          updateWithImage: gh<_i21.UpdateWithImageUseCase>(),
        ));
    gh.factory<_i24.AuthUseCases>(() => _i24.AuthUseCases(
          login: gh<_i13.LoginUseCase>(),
          register: gh<_i17.RegisterUseCase>(),
          getUser: gh<_i22.UserSessionUseCase>(),
          logout: gh<_i14.LogoutUseCase>(),
        ));
    gh.factory<_i25.CreatePostUSeCase>(
        () => _i25.CreatePostUSeCase(gh<_i15.PostsRepository>()));
    gh.factory<_i26.DeleteLikePostUseCase>(
        () => _i26.DeleteLikePostUseCase(gh<_i15.PostsRepository>()));
    gh.factory<_i27.DeletePostUseCase>(
        () => _i27.DeletePostUseCase(gh<_i15.PostsRepository>()));
    gh.factory<_i28.GetPostsByIdUseCase>(
        () => _i28.GetPostsByIdUseCase(gh<_i15.PostsRepository>()));
    gh.factory<_i29.GetPostsUseCase>(
        () => _i29.GetPostsUseCase(gh<_i15.PostsRepository>()));
    gh.factory<_i30.LikePostUseCase>(
        () => _i30.LikePostUseCase(gh<_i15.PostsRepository>()));
    gh.factory<_i31.PostsUseCases>(() => _i31.PostsUseCases(
          create: gh<_i25.CreatePostUSeCase>(),
          getPosts: gh<_i29.GetPostsUseCase>(),
          update: gh<_i19.UpdatePostUseCase>(),
          updateWithImage: gh<_i18.UpdatePostImageUseCase>(),
          getPostsById: gh<_i28.GetPostsByIdUseCase>(),
          delete: gh<_i27.DeletePostUseCase>(),
          like: gh<_i30.LikePostUseCase>(),
          deleteLike: gh<_i26.DeleteLikePostUseCase>(),
        ));
    return this;
  }
}

class _$AppModule extends _i32.AppModule {}
