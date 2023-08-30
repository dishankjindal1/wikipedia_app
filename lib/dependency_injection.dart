import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wikipedia_app/core/resources/network/dio_service.dart';
import 'package:wikipedia_app/data/apis/search_query/search_query_api.dart';
import 'package:wikipedia_app/data/repositories/wiki_data/wiki_data_repository.dart';
import 'package:wikipedia_app/domain/repositories/wiki_data/wiki_data_repository.dart';
import 'package:wikipedia_app/domain/use_cases/search_query/search_query_usecase.dart';
import 'package:wikipedia_app/utilites/router/router.dart';

class DependencyInjectionModule {
  Future<void> init() async {
    final Directory tempDirectoryPath = await getTemporaryDirectory();

    final AppNavigation router = AppNavigation();
    GetIt.instance.registerSingleton(router);

    final Dio dio = const DioService().call(tempDirectoryPath.path);
    GetIt.instance.registerSingleton(dio);

    /// Service(s)
    final SearchQueryApi searchQueryApi = SearchQueryApi(dio);
    GetIt.instance.registerSingleton(searchQueryApi);

    /// Repo(s)
    final WikiDataRepository wikiDataRepository = WikiDataRepositoryImpl(
      searchQueryApi,
    );
    GetIt.instance.registerSingleton(wikiDataRepository);

    /// Usecase(s)
    final WikiSearchQueryUsecase wikiSearchQueryUsecase =
        WikiSearchQueryUsecase(
      wikiDataRepository,
    );
    GetIt.instance.registerSingleton(wikiSearchQueryUsecase);
  }
}
