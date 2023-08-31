import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';

@immutable
class DioService {
  DioService(this.tempDirectoryPath) {
    _dio = _call();
  }

  final String tempDirectoryPath;

  late final Dio _dio;
  Dio get callMethod => _dio;

  CacheOptions get cacheInterceptorOptions => CacheOptions(
        store: HiveCacheStore(tempDirectoryPath),
        policy: CachePolicy.forceCache,
        hitCacheOnErrorExcept: [401, 403],
        maxStale: const Duration(days: 7),
        priority: CachePriority.normal,
        cipher: null,
        keyBuilder: CacheOptions.defaultCacheKeyBuilder,
        allowPostMethod: false,
      );

  Dio _call() {
    final Dio dio = Dio()
      ..interceptors.addAll([
        DioCacheInterceptor(options: cacheInterceptorOptions),
        LogInterceptor(responseBody: true, requestBody: true),
      ]);

    return dio;
  }
}
