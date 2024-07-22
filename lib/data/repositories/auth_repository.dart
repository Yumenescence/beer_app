import 'package:dio/dio.dart';

import '../models/user.dart';

class AuthRepository {
  final Dio _dio = Dio();

  Future<User?> login(String email, String password) async {
    try {
      final response = await _dio.get(
        'https://randomuser.me/api/',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        if (response.data['results'].isNotEmpty) {
          return User.fromJson(response.data['results'][0]);
        } else {
          return null;
        }
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Failed to load user: ${e.response?.statusCode}');
      } else {
        throw Exception('Failed to load user: ${e.message}');
      }
    }
  }
}
