abstract class DataState<T> {
  final T? data;
  final T? error;
  const DataState({
    this.data,
    this.error,
  }) : assert(
            (data != null && error == null) || (data == null && error != null));
}
