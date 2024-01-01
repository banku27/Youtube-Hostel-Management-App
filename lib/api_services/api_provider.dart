import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiProvider extends ChangeNotifier {
  final String baseUrl;
  final http.Client httpClient;
  late Future<String?> authToken;

  ApiProvider({
    required this.baseUrl,
    required this.httpClient,
  });

  Future<http.Response> getRequest(String endpoint,
      {Map<String, String>? headers}) async {
    final Uri uri = Uri.parse('$baseUrl$endpoint');
    final Map<String, String> headers = {
      'Content-Type': 'application/json'
      // 'Authorization': 'Bearer $token',
    };

    print("$baseUrl$endpoint");

    final response = await httpClient.get(uri, headers: headers);

    print(response.body);

    return response;
  }

  Future<http.Response> postRequest(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool includeBearerToken = false,
  }) async {
    final Uri uri = Uri.parse('$baseUrl$endpoint');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    print("$baseUrl$endpoint");

    final String jsonBody = body != null ? json.encode(body) : '';

    final response =
        await httpClient.post(uri, headers: headers, body: jsonBody);
    log("requesttt ${response.headers.toString()}");

    return response;
  }

  Future<http.Response> putRequest(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool includeBearerToken = false,
  }) async {
    final Uri uri = Uri.parse('$baseUrl$endpoint');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    print("$baseUrl$endpoint");

    final String jsonBody = body != null ? json.encode(body) : '';

    final response =
        await httpClient.put(uri, headers: headers, body: jsonBody);
    log("requesttt ${response.headers.toString()}");

    return response;
  }

  Future<http.Response> deleteRequest(
    String endpoint, {
    Map<String, String>? headers,
    bool includeBearerToken = false,
  }) async {
    final Uri uri = Uri.parse('$baseUrl$endpoint');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final response = await httpClient.delete(uri, headers: headers);

    print(response.body);

    return response;
  }
}
