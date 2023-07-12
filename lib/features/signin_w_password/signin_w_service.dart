import 'dart:developer';

import 'package:berana/shared/http_client.dart';

class BaseResponse {
  bool success;
  String message;

  BaseResponse({required this.success, required this.message});
}

class SignInResponse extends BaseResponse {
  final bool success;
  final String message;
  String? accessToken;

  SignInResponse({required this.success, required this.message, this.accessToken = null})
      : super(success: success, message: message);
}

class SignInService {
  static Future<bool> signInWithFacebook() async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> signInWithGoogle() async {
    try {
      var response = await HttpClient.get(path: '/api/oauth/google/');
      var data = response?.body;

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> signInWithApple() async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<SignInResponse> signInWithPassword(
      {required String email, required String password}) async {
    try {
      var response =
          await HttpClient.post(path: '/api/signin', body: {'email': email, 'password': password});

      var data = response?.body;

      return SignInResponse(
          success: true, message: 'Successfully Signed In', accessToken: data!['token']);
    } catch (e) {
      log(e.toString());
      return SignInResponse(success: false, message: 'Failed to Sign In');
    }
  }
}
