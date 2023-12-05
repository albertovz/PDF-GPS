import 'package:paw_rescue/src/domain/models/user_data.dart';
import 'package:paw_rescue/src/presentation/utils/validation_item.dart';

class ProfileUpdateState {
  ValidationItem id;
  ValidationItem username;
  ValidationItem image;

  ProfileUpdateState(
      {this.id = const ValidationItem(),
      this.username = const ValidationItem(),
      this.image = const ValidationItem()});

  toUser() => UserData(
      id: this.id.value,
      username: this.username.value,
      image: this.image.value);

  ProfileUpdateState copyWith(
          {ValidationItem? id,
          ValidationItem? username,
          ValidationItem? image}) =>
      ProfileUpdateState(
          id: id ?? this.id,
          username: username ?? this.username,
          image: image ?? this.image);

  bool isValid() {
    if (id.value.isEmpty ||
        id.error.isNotEmpty ||
        username.value.isEmpty ||
        username.error.isNotEmpty) {
      return false;
    }
    return true;
  }
}
