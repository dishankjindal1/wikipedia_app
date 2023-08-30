import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:wikipedia_app/domain/entities/wiki/wiki_entity.dart';
import 'package:wikipedia_app/domain/use_cases/search_query/search_query_usecase.dart';

final homeVMpod = ChangeNotifierProvider<HomeViewModel>((ref) {
  return HomeViewModel(
    GetIt.instance.get<WikiSearchQueryUsecase>(),
  );
});

class HomeViewModel extends ChangeNotifier with EquatableMixin {
  final WikiSearchQueryUsecase _searchQueryUsecase;

  HomeViewModel(
    this._searchQueryUsecase,
  );

  bool isLoading = false;
  bool hasError = false;
  String? errorMessage;

  List<WikiEntity> wikis = [];

  String? searchQuery;

  Future<void> fetchWiki([String? query]) async {
    try {
      isLoading = true;
      notifyListeners();

      hasError = false;
      errorMessage = null;
      // if no data is passed to the [query] then pick up the recent [searchQuery]
      searchQuery = query ?? searchQuery;
      // paginated
      final result = await _searchQueryUsecase.trigger(
          searchQuery, 1 + (wikis.length % 10));

      if (result.isNotEmpty) {
        if (result.first.hasError) {
          hasError = true;
          errorMessage = result.first.errorMessage;
          notifyListeners();
          return;
        }
      }
      wikis = result;
      notifyListeners();
    } catch (e) {
      hasError = true;
      errorMessage = e.toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    wikis = [];
    hasError = false;
    errorMessage = null;
    notifyListeners();
  }

  @override
  List<Object?> get props => [
        wikis,
        hasError,
        errorMessage,
      ];
}
