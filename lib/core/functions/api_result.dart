import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/core/functions/network_exception_model.dart';

part 'api_result.freezed.dart';

@freezed
class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;

  const factory ApiResult.failure(NetworkExceptionModel networkExceptions) =
      Failure<T>;
}
