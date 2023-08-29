import 'package:get_it/get_it.dart';
import 'package:wikipedia_app/utilites/router/router.dart';

class DependencyInjectionModule {
  Future<void> init() async {
    final router = AppNavigation();
    GetIt.instance.registerSingleton(router);
  }
}
