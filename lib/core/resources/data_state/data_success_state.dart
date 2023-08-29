import 'package:wikipedia_app/core/resources/data_state/abstract_data_state.dart';

class DataSuccess<T> extends DataState<T> {
  const DataSuccess({
    required T data,
  }) : super(data: data);
}
