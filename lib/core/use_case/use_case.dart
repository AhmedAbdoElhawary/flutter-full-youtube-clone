abstract class UseCase<ApiResult, P> {
  Future<ApiResult> call({required P params});
}

abstract class StreamUseCase<R, P> {
  Stream<R> call({required P params});
}