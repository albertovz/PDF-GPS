import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paw_rescue/src/domain/use_cases/auth/auth_usecases.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';
import 'package:paw_rescue/src/presentation/pages/auth/register/register_state.dart';
import 'package:paw_rescue/src/presentation/utils/validation_item.dart';

class RegisterEvent extends ChangeNotifier {
  // ESATADO
  RegisterState _state = RegisterState();
  RegisterState get state => _state;

  StreamController<Resource> _responseController = StreamController<Resource>();
  Stream<Resource> get response => _responseController.stream;

  // USE CASE
  AuthUseCases _authUseCases;

  RegisterEvent(this._authUseCases);

  register() async {
    if (_state.isValid()) {
      _responseController.add(Loading());
      final data = await _authUseCases.register
          .launch(_state.toUser());
      _responseController.add(data);
    }
  }

  changeEmail(String value) {
    _responseController.add(Init());
    final bool emailFormatValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    if (!emailFormatValid) {
      _state = _state.copyWith(
          email: const ValidationItem(error: 'No es un email válido'));
    } else if (value.length >= 6) {
      _state = state.copyWith(email: ValidationItem(value: value, error: ''));
    } else {
      _state = state.copyWith(
          email: const ValidationItem(error: 'Al menos 6 carácteres'));
    }
    notifyListeners();
  }

  changeUsername(String value) {
    _responseController.add(Init());
    if (value.length >= 3) {
      _state =
          state.copyWith(username: ValidationItem(value: value, error: ''));
    } else {
      _state = state.copyWith(
          username: const ValidationItem(error: 'Al menos 3 carácteres'));
    }
    notifyListeners();
  }

  changePassword(String value) {
    _responseController.add(Init());
    if (value.length >= 4) {
      _state =
          state.copyWith(password: ValidationItem(value: value, error: ''));
    } else {
      _state = state.copyWith(
          password: const ValidationItem(error: 'Al menos 4 carácteres'));
    }
    notifyListeners();
  }

  changeConfirmPassword(String value) {
    _responseController.add(Init());
    if (value.length >= 4) {
      _state = state.copyWith(
          confirmPassword: ValidationItem(value: value, error: ''));
    } else {
      _state = state.copyWith(
          confirmPassword:
              const ValidationItem(error: 'Al menos 4 carácteres'));
    }
    notifyListeners();
  }
}
