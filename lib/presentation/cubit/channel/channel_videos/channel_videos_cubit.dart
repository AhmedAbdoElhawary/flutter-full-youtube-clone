import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exception_model.dart';
import 'package:youtube/data/models/channel_details/my_subscriptions/my_subscriptions_details.dart';

import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/entities/parameters/channel_details_use_case_parameters.dart';
import 'package:youtube/domain/entities/parameters/clear_channel_videos_use_case_parameters.dart';
import 'package:youtube/domain/use_cases/channel/channel_details/get_videos_of_those_channels_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/channel_popular_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/channel_short_poupal_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/channel_short_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/channel_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/clear/clear_all_channel_short_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/clear/clear_all_channel_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/clear/clear_all_popular_channel_short_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/clear/clear_all_popular_channel_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/clear/clear_videos_of_those_channels_use_case.dart';
import 'package:youtube/domain/use_cases/channel/playlist/clear/clear_channel_playlists_use_case.dart';

part 'channel_videos_state.dart';
part 'channel_videos_cubit.freezed.dart';

class ChannelVideosCubit extends Cubit<ChannelVideosState> {
  final ChannelPopularVideosUseCase _popularVideosUseCase;
  final ChannelShortPopularVideosUseCase _shortPopularVideosUseCase;
  final ChannelShortVideosUseCase _shortVideosUseCase;
  final ChannelVideosUseCase _videosUseCase;
  final GetVideosOfThoseChannelsUseCase _getVideosOfThoseChannelsUseCase;
  final ClearAllChannelShortVideosUseCase _clearAllChannelShortVideosUseCase;
  final ClearAllChannelVideosUseCase _clearAllChannelVideosUseCase;
  final ClearAllPopularChannelShortVideosUseCase
      _clearAllPopularChannelShortVideosUseCase;
  final ClearAllPopularChannelVideosUseCase
      _clearAllPopularChannelVideosUseCase;
  final ClearVideosOfThoseChannelsUseCase _clearVideosOfThoseChannelsUseCase;
  final CleaChannelPlaylistsUseCase _cleaChannelPlaylistsUseCase;

  ChannelVideosCubit(
    this._videosUseCase,
    this._shortVideosUseCase,
    this._shortPopularVideosUseCase,
    this._popularVideosUseCase,
    this._getVideosOfThoseChannelsUseCase,
    this._clearAllChannelShortVideosUseCase,
    this._clearAllChannelVideosUseCase,
    this._clearAllPopularChannelShortVideosUseCase,
    this._clearAllPopularChannelVideosUseCase,
    this._clearVideosOfThoseChannelsUseCase,
    this._cleaChannelPlaylistsUseCase,
  ) : super(const ChannelVideosState.initial());

  static ChannelVideosCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> getPopularChannelVideos(String channelId) async {
    emit(const ChannelVideosState.loading());

    ApiResult<VideosDetails> popularVideosDetails = await _popularVideosUseCase
        .call(params: ChannelDetailsUseCaseParameters(channelId: channelId));

    popularVideosDetails.when(
        success: (videoDetails) =>
            emit(ChannelVideosState.popularVideosLoaded(videoDetails)),
        failure: (exception) => emit(ChannelVideosState.error(exception)));
  }

  Future<void> getPopularChannelShortVideos(String channelId) async {
    emit(const ChannelVideosState.loading());

    ApiResult<VideosDetails> shortPopularVideosDetails =
        await _shortPopularVideosUseCase.call(
            params: ChannelDetailsUseCaseParameters(channelId: channelId));

    shortPopularVideosDetails.when(
        success: (shortVideoDetails) => emit(
            ChannelVideosState.shortPopularVideosLoaded(shortVideoDetails)),
        failure: (exception) => emit(ChannelVideosState.error(exception)));
  }

  Future<void> getChannelShortVideos(String channelId) async {
    emit(const ChannelVideosState.loading());

    ApiResult<VideosDetails> shortVideosDetails = await _shortVideosUseCase
        .call(params: ChannelDetailsUseCaseParameters(channelId: channelId));

    shortVideosDetails.when(
        success: (shortVideoDetails) =>
            emit(ChannelVideosState.shortVideosLoaded(shortVideoDetails)),
        failure: (exception) => emit(ChannelVideosState.error(exception)));
  }

  Future<void> getChannelVideos(String channelId) async {
    emit(const ChannelVideosState.loading());

    ApiResult<VideosDetails> videosDetails = await _videosUseCase.call(
        params: ChannelDetailsUseCaseParameters(channelId: channelId));

    videosDetails.when(
        success: (videoDetails) =>
            emit(ChannelVideosState.channelVideosLoaded(videoDetails)),
        failure: (exception) => emit(ChannelVideosState.error(exception)));
  }

  Future<void> getVideosOfThoseChannels(
      MySubscriptionsDetails? mySubscriptionsDetails) async {
    emit(const ChannelVideosState.loading());
    if (mySubscriptionsDetails == null) {
      emit(const ChannelVideosState.initial());
      return;
    }
    ApiResult<List<VideosDetails>> videosDetails =
        await _getVideosOfThoseChannelsUseCase.call(
            params: GetVideosOfThoseChannelsUseCaseParameter(
                mySubscriptionsDetails: mySubscriptionsDetails));

    videosDetails.when(
        success: (videosDetails) {
          List<VideoDetailsItem> videosItems = [];
          for (final video in videosDetails) {
            List<VideoDetailsItem>? items = video.videoDetailsItem;
            if (items != null) videosItems.addAll(items);
          }
          emit(ChannelVideosState.videosOfThoseChannelsLoaded(videosItems));
        },
        failure: (exception) => emit(ChannelVideosState.error(exception)));
  }

  Future<void> clearChannelCachedDetails(String channelId) async {
    _clearAllChannelShortVideosUseCase.call(
        params: ClearAllChannelVideosUseCasePara(
            channelId: channelId, clearAll: false));
    _clearAllChannelVideosUseCase.call(
        params: ClearAllChannelVideosUseCasePara(
            channelId: channelId, clearAll: false));
    _clearAllPopularChannelShortVideosUseCase.call(
        params: ClearAllChannelVideosUseCasePara(
            channelId: channelId, clearAll: false));
    _clearAllPopularChannelVideosUseCase.call(
        params: ClearAllChannelVideosUseCasePara(
            channelId: channelId, clearAll: false));
    _clearVideosOfThoseChannelsUseCase.call(
        params: ClearAllChannelVideosUseCasePara(
            channelId: channelId, clearAll: false));
    _cleaChannelPlaylistsUseCase.call(
        params: ChannelDetailsUseCaseParameters(channelId: channelId));
  }
}
