import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:iuapp/data/network/token_interceptor.dart';
import 'package:iuapp/data/models/login_request.dart';
import 'package:iuapp/data/models/register_request.dart';
import 'package:iuapp/data/models/login_response.dart';
import 'package:iuapp/data/models/user_model.dart';
import 'package:iuapp/data/models/role_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'api_service.g.dart';
@RestApi(baseUrl: "https://captured-virgin-am-minds.trycloudflare.com/api")
abstract class ApiService {
  factory ApiService(Dio dio) {
    dio.interceptors.add(TokenInterceptor()); // Agrega el interceptor aquí
    return _ApiService(dio);
  }

  @POST("/login")
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST("/usuarios")
  Future<void> register(@Body() RegisterRequest request);

  @GET("/usuarios")
  Future<UserResponse> getUsers(@Query("page") int page, @Query("limit") int limit);









}
