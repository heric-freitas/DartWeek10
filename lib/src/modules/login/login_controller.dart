import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../core/exceptions/unauthorized_exception.dart';
import '../../services/auth/login_service.dart';
part 'login_controller.g.dart';

enum LoginStateStatus {
  initial, loading, success, error;
}

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final LoginService _loginService;

  @readonly
  var _status = LoginStateStatus.initial;

  @readonly
  String? _errorMessage;

  LoginControllerBase(this._loginService);

  @action
  Future<void> login(String email, String password) async {
    try {
      _status = LoginStateStatus.loading;
    await _loginService.execute(email, password);
    _status = LoginStateStatus.success;
    } on UnauthorizedException catch (_) {
      _errorMessage = 'Login ou senha inválidos';
      _status = LoginStateStatus.error;
    } catch (e, s) {
      log('Erro ao realizar o login', error: e, stackTrace: s);
      _errorMessage = 'Tente novamente mais tarde';
      _status = LoginStateStatus.error;
    }
  } 
}