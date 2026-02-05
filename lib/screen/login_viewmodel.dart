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
    required String type,
  }) async {
    state = true;
    final res = await repository.login(
      email: email,
      password: password,
      type :type
    );
    state = false;
    return res;
  }
  //==================================== verify Email ===================
  Future<ResponseModel> verifyEmail({
    required String email,
    required String token,
  }) async {
    state = true;
    final res = await repository.verifyEmail(email: email, token: token);
    state = false;
    return res;
  }

  //============================ sign in =======================
  Future<ResponseModel> signUp({
    required String email,
    required String password,
    required String fcm_token,
    required String platform,
  }) async {
    state = true;
    final res = await repository.signUp(
      email: email,
      password: password,
      fcm_token: fcm_token,
      platform: platform,
    );
    state = false;
    return res;
  }

  //============================== forgot password ===========================
  Future<ResponseModel> forgotPassword({required String email}) async {
    state = true;
    final res = await repository.forgotPassword(email: email);
    state = false;
    return res;
  }
}
