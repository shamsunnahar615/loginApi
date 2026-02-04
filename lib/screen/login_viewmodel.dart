import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loginapi/data/model/responde_model.dart';
import 'package:loginapi/data/repository/auth%20_repository.dart';
import 'package:loginapi/data/sources/sources/auth_api_service.dart';
import 'package:loginapi/network/api_clients.dart';


final userLoginProvider = StateNotifierProvider<LoginModelView, bool>(
      (ref) => LoginModelView(
    repository: AuthRepository(
      remoteSource: AuthApiService(apiClient: ApiClient()),
    ),
  ),
);

class LoginModelView extends StateNotifier<bool> {
  final AuthRepository repository;

  LoginModelView({required this.repository}) : super(false);

  // user register
  Future<ResponseModel> userRegister({
    required String email,
    required String password,
  }) async {
    state = true;
    final res = await repository.login(
      email: email,
      password: password,
    );
    state = false;
    return res;
  }
}