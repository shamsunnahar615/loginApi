import 'package:loginapi/data/model/responde_model.dart';
import 'package:loginapi/data/sources/sources/auth_api_service.dart';

class AuthRepository {
  final AuthApiService remoteSource;
  AuthRepository({required this.remoteSource});


  // ===================== login ========================

  Future<ResponseModel> login({
    required String email,
    required String password,
    required String type,
  }) async {
    return await remoteSource.login(email: email, password: password, type : type);
  }
  //============================== verify Email =======================
  Future<ResponseModel> verifyEmail({
    required String email,
    required String token,
  }) async {
    return await remoteSource.verifyEmail(email: email, token: token);
  }
  //=================================== sign in ===================
  Future<ResponseModel> signUp({
    required String email,
    required String password,
    required String fcm_token,
    required String platform,
  }) async {
    return await remoteSource.signUp(
      email: email,
      password: password,
      fcm_token: fcm_token,
      platform: platform,
    );
  }
  //=============================== forgot password =============================
  Future<ResponseModel> forgotPassword({required String email}) async{
    return await remoteSource.forgotPassword(email: email);
  }

}
