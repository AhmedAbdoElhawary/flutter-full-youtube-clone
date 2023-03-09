import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:youtube/core/functions/handling_errors/api_result.dart';
import 'package:youtube/core/functions/handling_errors/network_exception_model.dart';

import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/channel_details/my_subscriptions/my_subscriptions_details.dart';
import 'package:youtube/domain/entities/parameters/channel_details_use_case_parameters.dart';
import 'package:youtube/domain/use_cases/channel/channel_details/channel_sub_details_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_details/clear/clear_my_subscriptions_channels_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_details/delete_subscription_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_details/my_subscriptions_channels_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_details/subscribe_to_channel_use_case.dart';
import 'package:youtube/domain/use_cases/channel/my_info/clear_my_info_use_case.dart';
import 'package:youtube/domain/use_cases/channel/my_info/get_my_channel_info_use_case.dart';
import 'package:youtube/presentation/pages/subscriptions/logic/subscriptions_page_logic.dart';

part 'channel_details_state.dart';
part 'channel_details_cubit.freezed.dart';

class ChannelDetailsCubit extends Cubit<ChannelDetailsState> {
  final GetMyInfoUseCase _getMyInfoUseCase;
  final ClearMyInfoUseCase _clearMyInfoUseCase;
  final ChannelSubDetailsUseCase _channelSubDetailsUseCase;
  final DeleteSubscriptionUseCase _deleteSubscriptionUseCase;
  final SubscribeToChannelUseCase _subscribeToChannelUseCase;
  final MySubscriptionsChannelsUseCase _mySubscriptionsChannelsUseCase;
  final ClearMySubscriptionsChannelsUseCase
      _clearMySubscriptionsChannelsUseCase;
  ChannelDetailsCubit(
    this._getMyInfoUseCase,
    this._clearMyInfoUseCase,
    this._channelSubDetailsUseCase,
    this._deleteSubscriptionUseCase,
    this._subscribeToChannelUseCase,
    this._mySubscriptionsChannelsUseCase,
    this._clearMySubscriptionsChannelsUseCase,
  ) : super(const ChannelDetailsState.initial());

  static ChannelDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> getMyChannelInfo() async {
    emit(const ChannelDetailsState.subscriptionLoading());

    ApiResult<ChannelSubDetails> myInfo =
        await _getMyInfoUseCase.call(params: null);

    myInfo.when(
        success: (myInfo) =>
            emit(ChannelDetailsState.myChannelInfoLoaded(myInfo)),
        failure: (exception) =>
            emit(ChannelDetailsState.subscriptionError(exception)));
  }

  Future<void> getChannelSubDetails(String channelId) async {
    emit(const ChannelDetailsState.subscriptionLoading());

    ApiResult<ChannelSubDetails> channelSubDetails =
        await _channelSubDetailsUseCase.call(
            params: ChannelDetailsUseCaseParameters(channelId: channelId));

    channelSubDetails.when(
        success: (videoDetails) =>
            emit(ChannelDetailsState.channelSubDetailsLoaded(videoDetails)),
        failure: (exception) =>
            emit(ChannelDetailsState.subscriptionError(exception)));
  }

  Future<void> subscribeToChannel(String subscriptionId) async {
    emit(const ChannelDetailsState.subscriptionLoading());

    ApiResult<void> channelDetails = await _subscribeToChannelUseCase.call(
        params: ChannelDetailsUseCaseParameters(channelId: subscriptionId));

    channelDetails.when(
        success: (_) =>
            emit(const ChannelDetailsState.subscribeToChannelLoaded()),
        failure: (exception) =>
            emit(ChannelDetailsState.subscriptionError(exception)));
  }

  Future<void> deleteSubscription(String subscriptionId) async {
    emit(const ChannelDetailsState.subscriptionLoading());

    ApiResult<void> channelDetails = await _deleteSubscriptionUseCase.call(
        params:
            DeleteSubscriptionUseCaseParameter(subscriptionId: subscriptionId));

    channelDetails.when(
        success: (_) =>
            emit(const ChannelDetailsState.subscribeToChannelLoaded()),
        failure: (exception) =>
            emit(ChannelDetailsState.subscriptionError(exception)));
  }

  Future<void> getMySubscriptionsChannels() async {
    emit(const ChannelDetailsState.subscriptionLoading());

    ApiResult<MySubscriptionsDetails> channelDetails =
        await _mySubscriptionsChannelsUseCase.call(params: null);

    channelDetails.when(
        success: (mySubscriptionsDetails) {
          final logic = Get.find<SubscriptionsPageLogic>(tag: "1");
          logic.allSubscribedChannels = mySubscriptionsDetails;
          emit(ChannelDetailsState.mySubscriptionsChannelsLoaded(
              mySubscriptionsDetails));
        },
        failure: (exception) =>
            emit(ChannelDetailsState.subscriptionError(exception)));
  }

  Future<void> clearMySubscriptionsChannels() async {
    await _clearMySubscriptionsChannelsUseCase.call(params: null);
  }

  Future<void> clearMyChannelInfo() async {
    await _clearMyInfoUseCase.call(params: null);
  }
}
