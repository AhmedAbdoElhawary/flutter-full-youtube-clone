import 'package:get/get.dart';
import 'package:youtube/core/utility/injector.dart';
import 'package:youtube/domain/entities/parameters/clear_channel_videos_use_case_parameters.dart';

import 'package:youtube/domain/entities/parameters/channel_details_use_case_parameters.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/clear/clear_all_channel_short_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/clear/clear_all_channel_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/clear/clear_all_popular_channel_short_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/clear/clear_all_popular_channel_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/clear/clear_videos_of_those_channels_use_case.dart';
import 'package:youtube/domain/use_cases/channel/playlist/clear/clear_channel_playlists_use_case.dart';
class ChannelProfileLogic extends GetxController {
  final   _clearAllChannelShortVideosUseCase=injector<ClearAllChannelShortVideosUseCase>();
  final   _clearAllChannelVideosUseCase=injector<ClearAllChannelVideosUseCase>();
  final   _clearAllPopularChannelShortVideosUseCase=injector<ClearAllPopularChannelShortVideosUseCase>();
  final   _clearAllPopularChannelVideosUseCase=injector<ClearAllPopularChannelVideosUseCase>();
  final   _clearVideosOfThoseChannelsUseCase=injector<ClearVideosOfThoseChannelsUseCase>();
  final   _clearChannelPlaylistsUseCase=injector<ClearChannelPlaylistsUseCase>();

  final RxBool _isRecentlyVideosSelected = true.obs;

  bool get getRecentlyVideosSelected => _isRecentlyVideosSelected.value;

  set isRecentlyVideosSelected(bool value) =>
      _isRecentlyVideosSelected.value = value;


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
    _clearChannelPlaylistsUseCase.call(
        params: ChannelDetailsUseCaseParameters(channelId: channelId));
  }
}
