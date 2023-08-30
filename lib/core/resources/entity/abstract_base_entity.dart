import 'package:equatable/equatable.dart';

abstract class BaseEntity extends Equatable {
  final bool hasError;
  final String? errorMessage;
  const BaseEntity({
    this.hasError = false,
    this.errorMessage,
  });

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        hasError,
        errorMessage,
      ];
}
