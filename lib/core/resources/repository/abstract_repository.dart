import 'package:wikipedia_app/core/resources/data_state/abstract_data_state.dart';

abstract class Repository<Type, Query> {
  const Repository();

  Future<DataState<Type>> request([Query? params]);
}
