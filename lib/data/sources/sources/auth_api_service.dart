import 'package:loginapi/data/model/responde_model.dart';
import 'package:loginapi/data/sources/local/shared_preference/shared_preference.dart';
import 'package:loginapi/network/api_clients.dart';
import 'package:loginapi/network/api_endpoints.dart';

class AuthApiService {
  final ApiClient apiClient;
  AuthApiService({required this.apiClient});

  //============================== login ===============================
  Future<ResponseModel> login({
    required String email,
    required String password,
    required String type,
  }) async {
    try {
      final body = {"email": email, "password": password, "type": type};
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

  //================================= verify Email ========================
  Future<ResponseModel> verifyEmail({
    required String email,
    required String token,
  }) async {
    try {
      final body = {"email": email, "token": token};
      final response = await apiClient.postRequest(
        body: body,
        endpoints: ApiEndpoints.verifyEmail,
      );

      if (response['success'] == true) {
        if (response['onboarding_token'] != null) {
          await SharedPreferenceData.setRegisterToken(
            "${response['onboarding_token']}",
          );
        } else if (response['token'] != null) {
          await SharedPreferenceData.setRegisterToken("${response['token']}");
        }
        return ResponseModel(true, response['message']);
      } else {
        return ResponseModel(false, response['message']);
      }
    } catch (error) {
      return ResponseModel(false, error.toString());
    }
  }

  //================================= sign Up =================================
  Future<ResponseModel> signUp({
    required String email,
    required String password,
    required String fcm_token,
    required String platform,
  }) async {
    try {
      final body = {
        "email": email,
        "password": password,
        "fcm_token": fcm_token,
        "platform": platform,
      };

      final response = await apiClient.postRequest(
        endpoints: ApiEndpoints.signUp,
        body: body,
      );

      if (response['success'] == true) {
        await SharedPreferenceData.setToken(
          response['authorization']['access_token'],
        );
        return ResponseModel(true, response['message'], data: response['type']);
      } else {
        return ResponseModel(false, response['message']);
      }
    } catch (error) {
      return ResponseModel(false, error.toString());
    }
  }

  //=========================== forgot password ========================
  Future<ResponseModel> forgotPassword({required String email}) async {
    try {
      final body = {'email': email};
      final response = await apiClient.postRequest(
        endpoints: ApiEndpoints.forgotPassword,
        body: body,
      );

      if (response['success'] == true) {
        return ResponseModel(true, response['message']);
      } else {
        return ResponseModel(false, response['message']);
      }
    } catch (error) {
      return ResponseModel(false, error.toString());
    }
  }
}
