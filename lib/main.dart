import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikipedia_app/dependency_injection.dart';
import 'package:wikipedia_app/presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DependencyInjectionModule().init();

  runApp(
    const ProviderScope(
      child: WikipediaApp(),
    ),
  );
}
