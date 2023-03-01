abstract class FutureUseCase<ApiResult, P> {
  Future<ApiResult> call({required P params});
}

abstract class UseCase<T, P> {
  T call({required P params});
}

abstract class StreamUseCase<R, P> {
  Stream<R> call({required P params});
}
