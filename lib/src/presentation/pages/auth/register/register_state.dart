import 'package:paw_rescue/src/domain/models/user_data.dart';
import 'package:paw_rescue/src/presentation/utils/validation_item.dart';

class RegisterState {
  ValidationItem email;
  ValidationItem password;
  ValidationItem username;
  ValidationItem confirmPassword;

  RegisterState(
      {this.username = const ValidationItem(),
      this.email = const ValidationItem(),
      this.password = const ValidationItem(),
      this.confirmPassword = const ValidationItem()});

  toUser () => UserData(
    email: this.email.value,
    username: this.username.value,
    password: this.password.value
  );

  bool isValid() {
    if (username.value.isEmpty ||
        username.error.isNotEmpty ||
        email.value.isEmpty ||
        email.error.isNotEmpty ||
        password.value.isEmpty ||
        password.error.isNotEmpty ||
        confirmPassword.value.isEmpty ||
        confirmPassword.error.isNotEmpty ||
        (password.value != confirmPassword.value)
        ) {
          return false;
        }
      return true;
  }

  RegisterState copyWith ({
    ValidationItem? username,
    ValidationItem? email,
    ValidationItem? password,
    ValidationItem? confirmPassword
  }) => RegisterState(
    username: username ?? this.username,
    email: email ?? this.email,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword
  );
}
