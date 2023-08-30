import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wikipedia_app/core/resources/data_state/abstract_data_state.dart';
import 'package:wikipedia_app/core/resources/data_state/data_failure_state.dart';
import 'package:wikipedia_app/core/resources/data_state/data_success_state.dart';
import 'package:wikipedia_app/data/apis/search_query/search_query_api.dart';
import 'package:wikipedia_app/data/models/wiki/wiki_model.dart';
import 'package:wikipedia_app/domain/entities/wiki/wiki_entity.dart';
import 'package:wikipedia_app/domain/repositories/wiki_data/wiki_data_repository.dart';

class WikiDataRepositoryImpl extends WikiDataRepository {
  final SearchQueryApi _searchQueryApi;

  const WikiDataRepositoryImpl(this._searchQueryApi);

  @override
  Future<DataState<List<WikiEntity>>> request([(String?, int)? params]) async {
    try {
      assert(params != null);
      assert(params!.$1 != null);
      assert(params!.$1!.isNotEmpty);
      assert(params!.$2 > -1);

      final resp = await _searchQueryApi.call(params!.$1!, params.$2);

      log(resp.data.toString());

      return DataSuccess(
        data: await compute<Map<String, dynamic>, List<WikiEntity>>(
          WikiModel.parseToList,
          resp.data as Map<String, dynamic>,
        ),
      );
    } on DioException catch (e) {
      return DataFailure(error: e);
    } catch (e) {
      throw Exception('unknown Exception');
    }
  }
}
