import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:iuapp/data/network/token_interceptor.dart';
import 'package:iuapp/data/models/login_request.dart';
import 'package:iuapp/data/models/register_request.dart';
import 'package:iuapp/data/models/login_response.dart';
import 'package:iuapp/data/models/user_model.dart';
import 'package:iuapp/data/models/EnrollmentResponse.dart';
import 'package:iuapp/data/models/enrol_request.dart';
import 'package:iuapp/data/models/role_response.dart';
import '../models/progress_model.dart';

part 'api_service.g.dart';
@RestApi(baseUrl: "http://localhost:9000/api")
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
  @GET("/roles") // NUEVO: Método para obtener los roles
  Future<RoleResponse> getRoles();

  @PUT("/usuarios/{id}")
  Future<void> assignRoleToUser(
      @Path("id") String userId,
      @Body() Map<String, dynamic> body,
      );
  @DELETE("/usuarios/{id}")
  Future<void> deleteUser(@Path("id") String userId);

  @POST("/enroll")
  Future<void> enrollStudent(@Body() EnrolRequest request);

  // Nuevo método para obtener las matrículas
  @GET("/enrollments")
  Future<EnrollmentResponse> getEnrollments();

  //prueba de enpoint elTapia
  @POST("/progress")
  Future<void> createProgress(@Body() ProgressRequest progress);
}