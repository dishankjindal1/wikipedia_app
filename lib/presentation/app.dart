import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wikipedia_app/utilites/router/router.dart';

class WikipediaApp extends StatelessWidget {
  const WikipediaApp({super.key});

  AppNavigation get router => GetIt.instance.get<AppNavigation>();

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoApp.router(
        routerConfig: router.routerConfig,
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
        ],
      );
    } else if (Platform.isAndroid) {
      return MaterialApp.router(
        routerConfig: router.routerConfig,
      );
    } else {
      return WidgetsApp.router(
        color: Colors.teal,
        routerConfig: router.routerConfig,
      );
    }
  }
}
