import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';

@immutable
class DioService {
  const DioService();

  Dio call(String directoryPath) {
    final Dio dio = Dio();

    final cacheInterceptorOptions = CacheOptions(
      store: HiveCacheStore(directoryPath),
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      cipher: null,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: false,
    );

    dio.interceptors.addAll([
      LogInterceptor(responseBody: true, requestBody: true),
      DioCacheInterceptor(options: cacheInterceptorOptions)
    ]);
    return dio;
  }
}
