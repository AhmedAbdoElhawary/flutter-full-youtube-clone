part of 'channel_details_cubit.dart';

@freezed
class ChannelDetailsState with _$ChannelDetailsState {
  const factory ChannelDetailsState.initial() = _Initial;

  const factory ChannelDetailsState.subscriptionLoading() = SubscriptionLoading;

  const factory ChannelDetailsState.myChannelInfoLoaded(
      ChannelSubDetails info) = MyChannelInfoLoaded;

  const factory ChannelDetailsState.channelSubDetailsLoaded(
      ChannelSubDetails channelSubDetails) = ChannelSubDetailsLoaded;

  const factory ChannelDetailsState.subscribeToChannelLoaded() =
      SubscribeToChannelLoaded;

  const factory ChannelDetailsState.deleteSubscriptionLoaded() =
      DeleteSubscriptionLoaded;

  const factory ChannelDetailsState.mySubscriptionsChannelsLoaded(
          MySubscriptionsDetails mySubscriptionsDetails) =
      MySubscriptionsChannelsLoaded;

  const factory ChannelDetailsState.subscriptionError(
      NetworkExceptionModel networkExceptions) = SubscriptionError;
}
