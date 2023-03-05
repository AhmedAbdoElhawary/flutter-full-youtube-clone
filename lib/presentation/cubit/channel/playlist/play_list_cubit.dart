import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/core/functions/handling_errors/api_result.dart';
import 'package:youtube/core/functions/handling_errors/network_exception_model.dart';

import 'package:youtube/data/models/channel_details/playlists/playlists.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/entities/parameters/channel_details_use_case_parameters.dart';
import 'package:youtube/domain/use_cases/channel/playlist/channel_playlist_items_use_case.dart';
import 'package:youtube/domain/use_cases/channel/playlist/channel_playlists_use_case.dart';

part 'play_list_state.dart';
part 'play_list_cubit.freezed.dart';

class PlayListCubit extends Cubit<PlayListState> {
  final ChannelPlayListItemsUseCase _channelPlayListItemUseCase;
  final ChannelPlayListUseCase _channelPlayListUseCase;

  PlayListCubit(this._channelPlayListItemUseCase, this._channelPlayListUseCase)
      : super(const PlayListState.initial());

  static PlayListCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> getPlayListItems({required String playlistId}) async {
    emit(const PlayListState.playlistLoading());

    ApiResult<List<VideosDetails>> playListItemsDetails =
        await _channelPlayListItemUseCase.call(
            params:
                ChannelPlayListItemUseCaseParameter(playlistId: playlistId));

    playListItemsDetails.when(
        success: (playListVideos) =>
            emit(PlayListState.playListItemsLoaded(playListVideos)),
        failure: (exception) => emit(PlayListState.playlistError(exception)));
  }

  Future<void> getChannelPlayLists({required String channelId}) async {
    emit(const PlayListState.playlistLoading());

    ApiResult<PlayLists> playListDetails = await _channelPlayListUseCase.call(
        params: ChannelDetailsUseCaseParameters(channelId: channelId));

    playListDetails.when(
        success: (playLists) =>
            emit(PlayListState.channelPlayListLoaded(playLists)),
        failure: (exception) => emit(PlayListState.playlistError(exception)));
  }
}
