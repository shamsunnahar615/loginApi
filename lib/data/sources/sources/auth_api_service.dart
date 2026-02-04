import 'package:loginapi/data/model/responde_model.dart';
import 'package:loginapi/network/api_clients.dart';
import 'package:loginapi/network/api_endpoints.dart';

class AuthApiService {
  final ApiClient apiClient;
  AuthApiService({required this.apiClient});

  //============================== login ===============================
  Future<ResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final body = {"email": email, "password": password};
      final response = await apiClient.postRequest(
        body: body,
        endpoints: ApiEndpoints.login,
      );
      if (response["success"] == true) {
        return ResponseModel(true, response["message"]);
      } else {
        return ResponseModel(false, response["message"]);
      }
    } catch (error) {
      return ResponseModel(false, error.toString());
    }
  }
}
