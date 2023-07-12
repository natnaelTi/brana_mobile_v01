import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpClientResponse {
  int statusCode;
  Map<dynamic, dynamic>? body;
  HttpClientResponse({required this.statusCode, this.body});
}

class HttpClient {
  static Map<String, String> globalHeaders = {'Content-Type': 'application/json'};
  static String baseUrl = 'http://64.225.74.219';

  static void isSuccessful({required int? statusCode}) {
    if (statusCode == null) throw ('No Status Code Found');
    RegExp regExp = RegExp('2[0-9][0-9]');
    bool test = regExp.hasMatch(statusCode.toString());
    if (!test) throw ('Request is not successful');
  }

  static void isClientError({required int? statusCode}) {
    if (statusCode == null) throw ('No Status Code Found');
    RegExp regExp = RegExp('4[0-9][0-9]');
    bool test = regExp.hasMatch(statusCode.toString());
    if (!test) throw ('Request is not client error');
  }

  static void isServerError({required int? statusCode}) {
    if (statusCode == null) throw ('No Status Code Found');
    RegExp regExp = RegExp('5[0-9][0-9]');
    bool test = regExp.hasMatch(statusCode.toString());
    if (!test) throw ('Request is not server error');
  }

  static Uri getTargetUri({required String path}) {
    return Uri.parse(baseUrl + path);
  }

  static tryJsonDecode({required dynamic body}) {
    try {
      return json.decode(body);
    } catch (e) {
      return null;
    }
  }

  static Future<HttpClientResponse?> get(
      {String path = '', Map<String, String> headers = const {}}) async {
    var targetUri = getTargetUri(path: path);
    var request = http.Request('GET', targetUri);
    request.headers.addAll(globalHeaders);
    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);
    isSuccessful(statusCode: response.statusCode);
    var responseBody = tryJsonDecode(body: response.body);
    return HttpClientResponse(statusCode: response.statusCode, body: responseBody);
  }

  static Future<HttpClientResponse?> post(
      {String path = '',
      Map<String, String> headers = const {},
      Map<String, dynamic> body = const {}}) async {
    Uri targetUri = getTargetUri(path: path);
    http.Request request = http.Request('POST', targetUri);
    request.body = json.encode(body);
    request.headers.addAll(globalHeaders);
    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);

    isSuccessful(statusCode: response.statusCode);
    var responseBody = tryJsonDecode(body: response.body);
    return HttpClientResponse(statusCode: response.statusCode, body: responseBody);
  }

  static Future<HttpClientResponse?> put(
      {String path = '',
      Map<String, String> headers = const {},
      Map<String, dynamic> body = const {}}) async {
    var targetUri = getTargetUri(path: path);
    var request = http.Request('PUT', targetUri);
    request.body = json.encode(body);
    request.headers.addAll(globalHeaders);
    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);
    isSuccessful(statusCode: response.statusCode);
    var responseBody = tryJsonDecode(body: response.body);
    return HttpClientResponse(statusCode: response.statusCode, body: responseBody);
  }

  static Future<HttpClientResponse?> patch(
      {String path = '',
      Map<String, String> headers = const {},
      Map<String, dynamic> body = const {}}) async {
    var targetUri = getTargetUri(path: path);
    var request = http.Request('PATCH', targetUri);
    request.body = json.encode(body);
    request.headers.addAll(globalHeaders);
    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);
    isSuccessful(statusCode: response.statusCode);
    var responseBody = tryJsonDecode(body: response.body);
    return HttpClientResponse(statusCode: response.statusCode, body: responseBody);
  }

  static Future<HttpClientResponse?> delete(
      {String path = '',
      Map<String, String> headers = const {},
      Map<String, dynamic> body = const {}}) async {
    var targetUri = getTargetUri(path: path);
    var request = http.Request('DELETE', targetUri);
    request.headers.addAll(globalHeaders);
    request.headers.addAll(headers);
    request.body = json.encode(body);
    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);
    isSuccessful(statusCode: response.statusCode);
    var responseBody = tryJsonDecode(body: response.body);
    return HttpClientResponse(statusCode: response.statusCode, body: responseBody);
  }
}
