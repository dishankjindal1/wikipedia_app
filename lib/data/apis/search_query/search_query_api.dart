import 'package:dio/dio.dart';
import 'package:wikipedia_app/core/resources/network/dio_service.dart';
import 'package:wikipedia_app/utilites/constants/endpoints.dart';

class SearchQueryApi {
  final DioService _dioService;

  const SearchQueryApi(this._dioService);

  Future<Response<dynamic>> call(String query, int page) async {
    try {
      assert(query.isNotEmpty);
      const url = AppEndpoints.queryUrl;

      return _dioService.callMethod.get(
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
