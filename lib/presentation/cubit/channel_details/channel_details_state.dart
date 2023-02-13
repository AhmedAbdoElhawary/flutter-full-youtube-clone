part of 'channel_details_cubit.dart';

@freezed
class ChannelDetailsState with _$ChannelDetailsState {
  const factory ChannelDetailsState.initial() = _Initial;

  const factory ChannelDetailsState.loading() = Loading;

  const factory ChannelDetailsState.channelSubDetailsLoaded(
      ChannelSubDetails channelSubDetails) = ChannelSubDetailsLoaded;

  const factory ChannelDetailsState.error(NetworkExceptions networkExceptions) =
  Error;
}
