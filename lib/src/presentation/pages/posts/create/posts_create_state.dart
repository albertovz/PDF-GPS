import 'dart:io';

import 'package:paw_rescue/src/domain/models/post.dart';
import 'package:paw_rescue/src/presentation/utils/validation_item.dart';

class PostsCreateState {

  ValidationItem name;
  ValidationItem description;
  File? image;
  String category;
  String idUser;
  String error;
  String contentType;
  String latitud;
  String longitud;

  PostsCreateState ({
    this.name = const ValidationItem(),
    this.description = const ValidationItem(),
    this.image,
    this.category = 'CATEGORIES',
    this.idUser = '',
    this.error = '',
    this.contentType = '',
    this.latitud = '',
    this.longitud = ''
  });

  toPost() => Post(
    name: name.value,
    description: description.value,
    category: category,
    idUser: idUser,
    contentType: contentType,
    latitud: latitud,
    longitud: longitud
  );

  bool isValid () {
    if (name.value.isEmpty || name.error.isNotEmpty ||
      description.value.isEmpty || description.error.isNotEmpty ||
      image == null || category.isEmpty || idUser.isEmpty || latitud.isEmpty || longitud.isEmpty) {
        return false;
      }
      return true;
  }

  PostsCreateState copyWith({
    ValidationItem? name,
    ValidationItem? description,
    File? image,
    String? category,
    String? idUser,
    String? error,
    String? contentType,
    String? latitud,
    String? longitud
  }) => PostsCreateState(
    name: name ?? this.name,
    description: description ?? this.description,
    image: image ?? this.image,
    category: category ?? this.category,
    idUser: idUser ?? this.idUser,
    error: error ?? this.error,
    contentType: contentType ?? this.contentType,
    latitud: latitud ?? this.latitud,
    longitud: longitud ?? this.longitud
  );

}