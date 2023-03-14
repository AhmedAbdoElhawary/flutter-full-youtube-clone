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
  final _clearAllChannelShortVideos =
      injector<ClearAllChannelShortVideosUseCase>();
  final _clearAllChannelVideos = injector<ClearAllChannelVideosUseCase>();
  final _clearAllPopularChannelShortVideos =
      injector<ClearAllPopularChannelShortVideosUseCase>();
  final _clearAllPopularChannelVideos =
      injector<ClearAllPopularChannelVideosUseCase>();
  final _clearVideosOfThoseChannels =
      injector<ClearVideosOfThoseChannelsUseCase>();
  final _clearChannelPlaylists = injector<ClearChannelPlaylistsUseCase>();

  final RxBool _isRecentlyVideosSelected = true.obs;
  final RxBool _isRecentlyShortVideosSelected = true.obs;

  bool get getRecentlyShortVideosSelected =>
      _isRecentlyShortVideosSelected.value;

  set isRecentlyShortVideosSelected(bool value) {
    _isRecentlyShortVideosSelected.value = value;
    update(["update-channel-short-videos"]);

  }

  bool get getRecentlyVideosSelected => _isRecentlyVideosSelected.value;

  set isRecentlyVideosSelected(bool value) {
    _isRecentlyVideosSelected.value = value;
    update(["update-channel-videos"]);
  }

  Future<void> clearChannelCachedDetails(String channelId) async {
    _clearAllChannelShortVideos.call(
        params: ClearAllChannelVideosUseCasePara(
            channelId: channelId, clearAll: false));
    _clearAllChannelVideos.call(
        params: ClearAllChannelVideosUseCasePara(
            channelId: channelId, clearAll: false));
    _clearAllPopularChannelShortVideos.call(
        params: ClearAllChannelVideosUseCasePara(
            channelId: channelId, clearAll: false));
    _clearAllPopularChannelVideos.call(
        params: ClearAllChannelVideosUseCasePara(
            channelId: channelId, clearAll: false));
    _clearVideosOfThoseChannels.call(
        params: ClearAllChannelVideosUseCasePara(
            channelId: channelId, clearAll: false));
    _clearChannelPlaylists.call(
        params: ChannelDetailsUseCaseParameters(channelId: channelId));
  }
}
