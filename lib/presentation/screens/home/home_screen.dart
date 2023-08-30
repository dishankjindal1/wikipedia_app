import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikipedia_app/presentation/pods/home/home_pod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Timer? debounce;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeVMpod).fetchWiki('India');
    });
  }

  @override
  void activate() {
    super.activate();
    ref.read(homeVMpod).fetchWiki();
  }

  @override
  Widget build(BuildContext context) {
    final wikis = ref.watch(homeVMpod.select((value) => value.wikis));
    final isLoading = ref.watch(homeVMpod.select((value) => value.isLoading));
    final isDataHasError =
        ref.watch(homeVMpod.select((value) => value.hasError));

    return SafeArea(
      child: Material(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              margin: const EdgeInsets.only(bottom: 24),
              child: TextFormField(
                autofocus: true,
                onTap: () {
                  ref.read(homeVMpod).fetchWiki();
                },
                onChanged: (value) {
                  if (value.isEmpty) ref.read(homeVMpod).reset();
                  if (value.length < 3) return;
                  debounce?.cancel();
                  debounce = null;

                  debounce = Timer(const Duration(milliseconds: 300), () {
                    ref.read(homeVMpod).fetchWiki(value);
                  });
                },
              ),
            ),
            if (isDataHasError)
              if (isLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                const Expanded(
                  child: Center(
                    child: Text('Error in fetching the data'),
                  ),
                )
            else if (wikis.isEmpty)
              if (isLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                const Expanded(
                  child: Center(
                    child: Text('No Data'),
                  ),
                )
            else ...[
              Expanded(
                child: NotificationListener<ScrollNotification>(
                    onNotification: (notif) {
                      if (notif.metrics.pixels >=
                          notif.metrics.maxScrollExtent) {
                        if (notif.metrics.atEdge) {
                          debounce?.cancel();
                          debounce = null;

                          debounce =
                              Timer(const Duration(milliseconds: 300), () {
                            ref.read(homeVMpod).fetchWiki();
                          });
                        }
                      }
                      return true;
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final wiki = wikis[index];
                        return ListTile(
                          dense: true,
                          leading: AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(
                              wiki.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(wiki.title),
                          subtitle: Text(wiki.description),
                        );
                      },
                      itemCount: wikis.length,
                    )),
              ),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
