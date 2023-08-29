import 'package:wikipedia_app/core/resources/data_state/abstract_data_state.dart';

class DataFailure<T> extends DataState<T> {
  const DataFailure({
    required T error,
  }) : super(error: error);
}
