import 'package:wikipedia_app/core/resources/repository/abstract_repository.dart';
import 'package:wikipedia_app/domain/entities/wiki/wiki_entity.dart';

/// Here (String?, int) - [String] is [query] and [int] is [page] index
abstract class WikiDataRepository
    extends Repository<List<WikiEntity>, (String?, int)> {
  const WikiDataRepository();
}
