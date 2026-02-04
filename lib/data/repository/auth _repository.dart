import 'package:loginapi/data/model/responde_model.dart';
import 'package:loginapi/data/sources/sources/auth_api_service.dart';

class AuthRepository {
  final AuthApiService remoteSource;
  AuthRepository({required this.remoteSource});


  // ===================== login ========================

  Future<ResponseModel> login({
    required String email,
    required String password,
  }) async {
    return await remoteSource.login(email: email, password: password);
  }
}
