import 'package:wikipedia_app/core/resources/data_state/data_failure_state.dart';
import 'package:wikipedia_app/core/resources/repository/abstract_repository.dart';
import 'package:wikipedia_app/domain/entities/wiki/wiki_entity.dart';

class WikiSearchQueryUsecase {
  final Repository<List<WikiEntity>, (String?, int)> wikiDataRepo;

  const WikiSearchQueryUsecase(this.wikiDataRepo);

  Future<List<WikiEntity>> trigger(String? query, int page) async {
    try {
      assert(query != null);
      assert(query!.isNotEmpty);

      final result = await wikiDataRepo.request((query, page));

      if (result is DataFailure) {
        return [
          WikiEntity.error(
            errorMessage: result.error.toString(),
          )
        ];
      }

      return result.data!;
    } catch (e) {
      return [
        WikiEntity.error(
          errorMessage: e.toString(),
        )
      ];
    }
  }
}
