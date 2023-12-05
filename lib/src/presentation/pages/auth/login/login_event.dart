import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paw_rescue/src/domain/use_cases/auth/auth_usecases.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';
import 'package:paw_rescue/src/presentation/pages/auth/login/login_state.dart';
import 'package:paw_rescue/src/presentation/utils/validation_item.dart';

class LoginEvent extends ChangeNotifier {
  //STATES
  LoginState _state = LoginState();
  StreamController<Resource> _responseController = StreamController<Resource>();
  Stream<Resource> get response => _responseController.stream;

  //GETTERS
  LoginState get state => _state;

  //USE CASES
  AuthUseCases _authUseCases;

  LoginEvent(this._authUseCases);

  void login() async {
    if (state.isValid()) {
      _responseController.add(Loading());
      final data = await _authUseCases.login
          .launch(email: _state.email.value, password: _state.password.value);
      _responseController.add(data);
    }
  }

  //SETTERS
  void changeEmail(String value) {
    _responseController.add(Init());
    final bool emailFormatValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    if (!emailFormatValid) {
      _state = _state.copyWith(
          email: const ValidationItem(error: 'No es un email válido'));
    } else if (value.length >= 6) {
      _state = _state.copyWith(email: ValidationItem(value: value, error: ''));
    } else {
      _state = _state.copyWith(
          email: const ValidationItem(error: 'Al menos 6 carácteres'));
    }

    notifyListeners();
  }

  void changePassword(String value) {
    _responseController.add(Init());
    if (value.length >= 6) {
      _state =
          _state.copyWith(password: ValidationItem(value: value, error: ''));
    } else {
      _state = _state.copyWith(
          password: const ValidationItem(error: 'Al menos 6 carácteres'));
    }

    notifyListeners();
  }
}
