import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/paystack_models/api_response.dart';

class ApiService {
  final Dio _dio = Dio();
  BaseOptions options = BaseOptions(
    connectTimeout: Duration(milliseconds: 50000),
    receiveTimeout: Duration(milliseconds: 50000),
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${dotenv.env['SECRET_KEY']}",
    },
  );

  ApiService() {
    _dio.options = options;
  }

  Future<ApiResponse> post({
    required String url,
    FormData? formData,
    String? data,
  }) async {
    _dio.options = options;
    Response response;
    final ApiResponse apiResponse = ApiResponse();
    try {
      response = await _dio.post(
        url,
        data: formData ?? data,
      );
      final raw = jsonDecode(jsonEncode(response.data));
      apiResponse.data = raw["data"] ?? raw;
      apiResponse.statusCode = response.statusCode;
    } catch (e) {
      if (e is DioError) {
        apiResponse.error = {"message": e.response?.data};
        apiResponse.statusCode = e.response?.statusCode;
      } else {
        apiResponse.error = {"message": "Unknown error occurred!"};
        apiResponse.statusCode = null;
      }
    }
    return apiResponse;
  }

  Future<ApiResponse> put({
    required String url,
    FormData? formData,
    String? data,
  }) async {
    _dio.options = options;
    Response response;
    final ApiResponse apiResponse = ApiResponse();
    try {
      response = await _dio.put(
        url,
        data: formData ?? data,
      );
      final raw = jsonDecode(jsonEncode(response.data));
      apiResponse.data = raw["data"] ?? raw;
      apiResponse.statusCode = response.statusCode;
    } catch (e) {
      if (e is DioError) {
        apiResponse.error = {"message": e.response?.data};
        apiResponse.statusCode = e.response?.statusCode;
      } else {
        apiResponse.error = {"message": "Unknown error occurred!"};
        apiResponse.statusCode = null;
      }
    }
    return apiResponse;
  }

  Future<ApiResponse> get({
    required String url,
    Map<String, dynamic>? mapValue = const <String, dynamic>{},
  }) async {
    _dio.options = options;
    Response response;
    final ApiResponse apiResponse = ApiResponse();
    try {
      response = await _dio.get(
        url,
        queryParameters: mapValue,
      );
      final raw = jsonDecode(jsonEncode(response.data));
      if (raw is List) {
        apiResponse.data = raw;
      } else {
        apiResponse.data = raw["data"] ?? raw;
      }
      apiResponse.statusCode = response.statusCode;
    } catch (e) {
      if (e is DioError) {
        apiResponse.error = {"message": e.response?.data};
        apiResponse.statusCode = e.response?.statusCode;
      } else {
        apiResponse.error = {"message": "Unknown error occurred!"};
        apiResponse.statusCode = null;
      }
    }
    return apiResponse;
  }
}
