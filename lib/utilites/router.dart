import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:wikipedia_app/presentation/screens/home/home_screen.dart';
import 'package:wikipedia_app/presentation/screens/wiki_detail/wiki_detail_screen.dart';

class AppNavigation {
  final GoRouter routerConfig = GoRouter(
    initialLocation: '/',
    routes: appRouter,
  );
}

List<RouteBase> get appRouter => [
      homeRoute,
      wikiDetailRoute,
    ];

/// HOME SCREEN CONFIGURATION
RouteBase get homeRoute => GoRouteData.$route(
      path: '/',
      name: 'HomeRoute',
      factory: HomeRouteExtension._fromState,
    );

extension HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

class HomeRoute extends GoRouteData {
  const HomeRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

/// WIKI DETAIL SCREEN CONFIGURATION
RouteBase get wikiDetailRoute => GoRouteData.$route(
      path: '/detail/:id',
      name: 'WikiDetailRoute',
      factory: WikiDetailRouteExtension._fromState,
    );

extension WikiDetailRouteExtension on WikiDetailRoute {
  static WikiDetailRoute _fromState(GoRouterState state) =>
      WikiDetailRoute(_convertMapValue('id', state.pathParameters, int.parse)!);

  String get location => GoRouteData.$location(
        '/detail/$id',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

class WikiDetailRoute extends GoRouteData {
  const WikiDetailRoute(this.id);

  final int id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return WikiDetailScreen(id: id);
  }
}

T? _convertMapValue<T>(
  String key,
  Map<String, String> map,
  T Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}
