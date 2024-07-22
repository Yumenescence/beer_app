import 'package:dio/dio.dart';
import 'package:photos_app/data/models/photo.dart';

class PhotosRepository {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.pexels.com/v1/curated?per_page=50';
  final String _apiKey = 'e1diXxFeyPN9BNM7ZB6EL5zQKqcebipeIVTpALvHNaFOGxNSkE9beBBw';

  Future<List<Photo>> fetchPhotos() async {
    final response = await _dio.get(
      _baseUrl,
      options: Options(headers: {'Authorization': _apiKey}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['photos'];
      return data.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
