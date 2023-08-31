import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikipedia_app/presentation/pods/home/home_pod.dart';

class WikiDetailScreen extends ConsumerWidget {
  const WikiDetailScreen({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wiki = ref.watch(homeVMpod.select((value) => value.wikis[id]));
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Align(
            child: SizedBox.square(
              dimension: 250,
              child: Image.network(
                wiki.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Align(
            child: Text(wiki.title),
          ),
          const SizedBox(height: 24),
          Align(
            child: Text(wiki.description),
          ),
        ],
      ),
    );
  }
}
