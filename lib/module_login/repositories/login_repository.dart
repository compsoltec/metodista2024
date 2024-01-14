import '../providers/login_provider.dart';

class LoginRepository {
  final LoginProvider api;

  LoginRepository({required this.api});

  getToken() {
    return api.getLogin();
  }
}
