import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exception_model.dart';

import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/domain/entities/channel_details_use_case_parameters.dart';
import 'package:youtube/domain/use_cases/channel_details/channel_sub_details_use_case.dart';
import 'package:youtube/domain/use_cases/channel_details/delete_subscription_use_case.dart';
import 'package:youtube/domain/use_cases/channel_details/my_subscriptions_channels_use_case.dart';
import 'package:youtube/domain/use_cases/channel_details/subscribe_to_channel_use_case.dart';

part 'channel_details_state.dart';
part 'channel_details_cubit.freezed.dart';

class ChannelDetailsCubit extends Cubit<ChannelDetailsState> {
  final ChannelSubDetailsUseCase _channelSubDetailsUseCase;
  final DeleteSubscriptionUseCase _deleteSubscriptionUseCase;
  final SubscribeToChannelUseCase _subscribeToChannelUseCase;
  final MySubscriptionsChannelsUseCase _mySubscriptionsChannelsUseCase;

  ChannelDetailsCubit(
      this._channelSubDetailsUseCase,
      this._deleteSubscriptionUseCase,
      this._subscribeToChannelUseCase,
      this._mySubscriptionsChannelsUseCase)
      : super(const ChannelDetailsState.initial());

  static ChannelDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> getChannelSubDetails(String channelId) async {
    emit(const ChannelDetailsState.loading());

    ApiResult<ChannelSubDetails> channelSubDetails =
        await _channelSubDetailsUseCase.call(
            params: ChannelDetailsUseCaseParameters(channelId: channelId));

    channelSubDetails.when(
        success: (videoDetails) =>
            emit(ChannelDetailsState.channelSubDetailsLoaded(videoDetails)),
        failure: (exception) => emit(ChannelDetailsState.error(exception)));
  }

  Future<void> subscribeToChannel(String channelId) async {
    emit(const ChannelDetailsState.loading());

    ApiResult<void> channelDetails = await _subscribeToChannelUseCase.call(
        params: ChannelDetailsUseCaseParameters(channelId: channelId));

    channelDetails.when(
        success: (_) =>
            emit(const ChannelDetailsState.subscribeToChannelLoaded()),
        failure: (exception) => emit(ChannelDetailsState.error(exception)));
  }

  Future<void> deleteSubscription() async {
    emit(const ChannelDetailsState.loading());

    ApiResult<void> channelDetails =
        await _deleteSubscriptionUseCase.call(params: null);

    channelDetails.when(
        success: (_) =>
            emit(const ChannelDetailsState.subscribeToChannelLoaded()),
        failure: (exception) => emit(ChannelDetailsState.error(exception)));
  }

  Future<void> getMySubscriptionsChannels() async {
    emit(const ChannelDetailsState.loading());

    ApiResult<void> channelDetails =
        await _mySubscriptionsChannelsUseCase.call(params: null);

    channelDetails.when(
        success: (_) =>
            emit(const ChannelDetailsState.mySubscriptionsChannelsLoaded()),
        failure: (exception) => emit(ChannelDetailsState.error(exception)));
  }
}
