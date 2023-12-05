import 'package:flutter/material.dart';
import 'package:paw_rescue/src/domain/use_cases/auth/auth_usecases.dart';

class HomeEvent extends ChangeNotifier {

  AuthUseCases _authUseCases;
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  HomeEvent(this._authUseCases);

  set currentIndex (int index) {
    _currentIndex = index;
    notifyListeners();
  }

}
