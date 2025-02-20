import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("Error en la API: ${err.response?.data}");
    return handler.next(err);
  }
}
