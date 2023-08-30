import 'package:dio/dio.dart';
import 'package:wikipedia_app/utilites/constants/endpoints.dart';

class SearchQueryApi {
  final Dio _dio;

  const SearchQueryApi(this._dio);

  Future<Response<dynamic>> call(String query, int page) async {
    try {
      assert(query.isNotEmpty);
      const url = AppEndpoints.queryUrl;

      return _dio.get(
        url,
        queryParameters: {
          'gpssearch': query,
          'gpslimit': 10 * page,
          'pilimit': 10 * page,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
