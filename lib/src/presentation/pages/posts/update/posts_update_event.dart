import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paw_rescue/src/domain/models/post.dart';
import 'package:paw_rescue/src/domain/use_cases/auth/auth_usecases.dart';
import 'package:paw_rescue/src/domain/use_cases/posts/posts_usecases.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';
import 'package:paw_rescue/src/presentation/pages/posts/update/posts_update_state.dart';
import 'package:paw_rescue/src/presentation/utils/validation_item.dart';
import 'package:image_picker/image_picker.dart';

class PostsUpdateEvent extends ChangeNotifier {
  PostsUpdateState _state = PostsUpdateState();
  PostsUpdateState get state => _state;

  File? _imageFile;
  File? get imageFile => _imageFile;

  AuthUseCases _authUseCases;
  PostsUseCases _postsUseCases;

  Resource _response = Init();
  Resource get response => _response;

  PostsUpdateEvent(this._authUseCases, this._postsUseCases) {
    _state =
        _state.copyWith(idUser: _authUseCases.getUser.userSession?.uid ?? '');
  }

  Future<void> loadData(Post post) async {
    // print('Argumentos: ${post.toJson()}');
    print(_state.id.isEmpty);
    if (_state.id.isEmpty) {
      _state = _state.copyWith(
          id: post.id,
          name: ValidationItem(value: post.name),
          description: ValidationItem(value: post.description),
          image: post.image,
          idUser: post.idUser,
          category: post.category);
    }
  }

  updatePost() async {
    if (_state.isValid()) {
      _response = Loading();
      notifyListeners();
      if (_imageFile == null) {
        // SIN IMAGEN
        _response = await _postsUseCases.update.launch(_state.toPost());
      } else {
        _response = await _postsUseCases.updateWithImage
            .launch(_state.toPost(), _imageFile!);
      }
      notifyListeners();
    } else {
      _state = _state.copyWith(error: 'Debes completar todos los campos');
      notifyListeners();
    }
  }

  changeName(String value) {
    if (value.length >= 3) {
      _state = _state.copyWith(name: ValidationItem(value: value, error: ''));
    } else {
      _state = _state.copyWith(
          name: ValidationItem(value: value, error: 'Al menos 3 carácteres'));
    }
    notifyListeners();
  }

  changeDescription(String value) {
    if (value.length >= 6) {
      _state =
          _state.copyWith(description: ValidationItem(value: value, error: ''));
    } else {
      _state = _state.copyWith(
          description:
              ValidationItem(value: value, error: 'Al menos 6 carácteres'));
    }
    notifyListeners();
  }

  changeRadioCategory(String value) {
    _state = _state.copyWith(category: value);
    print('Radio : ${_state.category}');
    notifyListeners();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageFile = File(image.path);
      notifyListeners();
    }
  }

  Future<void> takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      notifyListeners();
    }
  }

  resetResponse() {
    _response = Init();
    notifyListeners();
  }
}
