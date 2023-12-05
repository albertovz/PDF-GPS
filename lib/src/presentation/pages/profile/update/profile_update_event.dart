import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';
import 'package:paw_rescue/src/domain/models/user_data.dart';
import 'package:paw_rescue/src/domain/use_cases/users/users_usecases.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';
import 'package:paw_rescue/src/presentation/pages/profile/update/profile_update_state.dart';
import 'package:paw_rescue/src/presentation/utils/validation_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUpdateEvent extends ChangeNotifier {
  UsersUseCase _usersUseCase;
  ProfileUpdateState _state = ProfileUpdateState();
  ProfileUpdateState get state => _state;

  Resource _response = Init();
  Resource get response => _response;

  File? _imageFile;
  File? get imageFile => _imageFile;

  ProfileUpdateEvent(this._usersUseCase);

  update() async {

    if (_state.isValid()) {
      _response = Loading();
      notifyListeners();
      if (_imageFile == null) {
        _response =
            await _usersUseCase.updateWithoutImage.launch(_state.toUser());
      } else {
        _response = await _usersUseCase.updateWithImage
            .launch(_state.toUser(), _imageFile!);
      }
    }
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      print('No hay conexión a internet');
      // No hay conexión a Internet
      return false;
    } else {
      print('Hay conexión a internet');
      // Hay conexión a Internet
      return true;
    }
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
      _imageFile = File(image.path);
      notifyListeners();
    }
  }

  loadData(UserData userData) {
    _state = _state.copyWith(
        id: ValidationItem(value: userData.id),
        username: ValidationItem(value: userData.username),
        image: ValidationItem(value: userData.image));
    WidgetsBinding.instance.addPostFrameCallback(((timeStamp) {
      notifyListeners();
    }));
  }

  changeUsername(String value) {
    if (value.length >= 3) {
      _state =
          state.copyWith(username: ValidationItem(value: value, error: ''));
    } else {
      _state = state.copyWith(
          username: const ValidationItem(error: 'Al menos 3 carácteres'));
    }
    notifyListeners();
  }

  resetResponse() {
    _response = Init();
    notifyListeners();
  }
}
