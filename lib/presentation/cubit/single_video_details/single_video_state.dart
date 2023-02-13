part of 'single_video_cubit.dart';

@freezed
class SingleVideoState with _$SingleVideoState {
  const factory SingleVideoState.initial() = _Initial;

  const factory SingleVideoState.loading() = Loading;

  const factory SingleVideoState.videoDetailsLoaded(
      VideosDetails videoDetails) = VideoDetailsLoaded;

  const factory SingleVideoState.error(NetworkExceptions networkExceptions) =
  Error;
}
