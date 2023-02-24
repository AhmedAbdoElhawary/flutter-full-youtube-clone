# Diff Details

Date : 2023-02-20 19:35:29

Directory d:\\flutter_projects\\main\\youtube-flutter-clone

Total : 82 files,  2527 codes, -180 comments, 317 blanks, all 2664 lines

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [android/app/build.gradle](/android/app/build.gradle) | Groovy | 2 | 0 | 2 | 4 |
| [lib/core/functions/api_result.freezed.dart](/lib/core/functions/api_result.freezed.dart) | Dart | -8 | 0 | -2 | -10 |
| [lib/core/functions/network_exception_model.dart](/lib/core/functions/network_exception_model.dart) | Dart | 6 | 0 | 3 | 9 |
| [lib/core/functions/network_exceptions.dart](/lib/core/functions/network_exceptions.dart) | Dart | -9 | 0 | 1 | -8 |
| [lib/core/functions/reformat/views_reformat.dart](/lib/core/functions/reformat/views_reformat.dart) | Dart | 10 | 0 | 4 | 14 |
| [lib/core/resources/color_manager.dart](/lib/core/resources/color_manager.dart) | Dart | 1 | 0 | 0 | 1 |
| [lib/core/utility/constants.dart](/lib/core/utility/constants.dart) | Dart | 1 | 0 | 0 | 1 |
| [lib/core/utility/injector.dart](/lib/core/utility/injector.dart) | Dart | 11 | 0 | 1 | 12 |
| [lib/core/widgets/multi_bloc_provider.dart](/lib/presentation/common_widgets/multi_bloc_provider.dart) | Dart | 4 | 0 | 0 | 4 |
| [lib/data/data_sources/remote/api/channel/channel_apis.g.dart](/lib/data/data_sources/remote/api/channel/channel_apis.g.dart) | Dart | 30 | 0 | 1 | 31 |
| [lib/data/data_sources/remote/api/search/auto_complete_search/auto_complete_text_apis.dart](/lib/data/data_sources/remote/api/search/auto_complete_search/auto_complete_text_apis.dart) | Dart | 19 | 0 | 7 | 26 |
| [lib/data/data_sources/remote/api/single_video/commet/comment_apis.g.dart](/lib/data/data_sources/remote/api/single_video/commet/comment_apis.g.dart) | Dart | 1 | 0 | 0 | 1 |
| [lib/data/data_sources/remote/api/single_video/single_video_apis.g.dart](/lib/data/data_sources/remote/api/single_video/single_video_apis.g.dart) | Dart | 1 | 0 | 0 | 1 |
| [lib/data/data_sources/remote/api/videos/try.dart](/lib/data/data_sources/remote/api/videos/try.dart) | Dart | 0 | 220 | 1 | 221 |
| [lib/data/data_sources/remote/api/videos/videos_apis.dart](/lib/data/data_sources/remote/api/videos/videos_apis.dart) | Dart | 2 | 0 | 0 | 2 |
| [lib/data/data_sources/remote/api/videos/videos_apis.g.dart](/lib/data/data_sources/remote/api/videos/videos_apis.g.dart) | Dart | 6 | 0 | 0 | 6 |
| [lib/data/models/channel_details/channel_details.dart](/lib/data/models/channel_details/channel_details.dart) | Dart | -8 | 0 | -3 | -11 |
| [lib/data/models/channel_details/channel_details.g.dart](/lib/data/models/channel_details/channel_details.g.dart) | Dart | -14 | 0 | -1 | -15 |
| [lib/data/models/channel_details/channel_sub_details/channel_sub_details_extension.dart](/lib/data/models/channel_details/channel_sub_details/channel_sub_details_extension.dart) | Dart | 20 | 1 | 5 | 26 |
| [lib/data/models/channel_details/my_subscriptions_details.g.dart](/lib/data/models/channel_details/my_subscriptions_details.g.dart) | Dart | 42 | 4 | 7 | 53 |
| [lib/data/models/common/thumbnail_details/high_thumbnail_details.dart](/lib/data/models/common/thumbnail_details/high_thumbnail_details.dart) | Dart | 11 | 0 | 5 | 16 |
| [lib/data/models/common/thumbnail_details/high_thumbnail_details.g.dart](/lib/data/models/common/thumbnail_details/high_thumbnail_details.g.dart) | Dart | 10 | 4 | 4 | 18 |
| [lib/data/models/searched_video_details/searched_video_details.dart](/lib/data/models/searched_video_details/searched_video_details.dart) | Dart | 61 | 0 | 15 | 76 |
| [lib/data/models/searched_video_details/searched_video_details.g.dart](/lib/data/models/searched_video_details/searched_video_details.g.dart) | Dart | 45 | 4 | 7 | 56 |
| [lib/data/models/searched_video_details/searched_video_extension.dart](/lib/data/models/searched_video_details/searched_video_extension.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/data/models/suggestion_texts/suggestion_texts.dart](/lib/data/models/suggestion_texts/suggestion_texts.dart) | Dart | 6 | 0 | 3 | 9 |
| [lib/data/models/videos_details/video_details_extension.dart](/lib/data/models/videos_details/video_details_extension.dart) | Dart | 36 | 1 | 6 | 43 |
| [lib/data/models/videos_details/videos_details.dart](/lib/data/models/videos_details/videos_details.dart) | Dart | -4 | 0 | -3 | -7 |
| [lib/data/models/videos_details/videos_details.g.dart](/lib/data/models/videos_details/videos_details.g.dart) | Dart | -4 | 0 | -1 | -5 |
| [lib/data/repositories_impl/channel/channel_details_repo_impl.dart](/lib/data/repositories_impl/channel/channel_details_repo_impl.dart) | Dart | 3 | 0 | 2 | 5 |
| [lib/data/repositories_impl/channel/channel_playlist_repo_impl.dart](/lib/data/repositories_impl/channel/channel_playlist_repo_impl.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/data/repositories_impl/channel/channel_videos_repo_impl.dart](/lib/data/repositories_impl/channel/channel_videos_repo_impl.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/data/repositories_impl/search_details_repo_impl.dart](/lib/data/repositories_impl/search_details_repo_impl.dart) | Dart | 60 | 1 | 4 | 65 |
| [lib/data/repositories_impl/single_video_details/single_video_details_repo_impl.dart](/lib/data/repositories_impl/single_video_details/single_video_details_repo_impl.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/data/repositories_impl/single_video_details/video_comment_details_repo_impl.dart](/lib/data/repositories_impl/single_video_details/video_comment_details_repo_impl.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/data/repositories_impl/videos_details_repo_impl.dart](/lib/data/repositories_impl/videos_details_repo_impl.dart) | Dart | 5 | 0 | 1 | 6 |
| [lib/domain/repositories/search_details_repository.dart](/lib/domain/repositories/search_details_repository.dart) | Dart | 2 | 0 | 0 | 2 |
| [lib/domain/use_cases/channel_details/channel_videos/channel_popular_videos_use_case.dart](/lib/domain/use_cases/channel_details/channel_videos/channel_popular_videos_use_case.dart) | Dart | -2 | 0 | 0 | -2 |
| [lib/domain/use_cases/channel_details/channel_videos/channel_short_poupal_videos_use_case.dart](/lib/domain/use_cases/channel_details/channel_videos/channel_short_poupal_videos_use_case.dart) | Dart | -2 | 0 | 0 | -2 |
| [lib/domain/use_cases/channel_details/channel_videos/channel_short_videos_use_case.dart](/lib/domain/use_cases/channel_details/channel_videos/channel_short_videos_use_case.dart) | Dart | -2 | 0 | 0 | -2 |
| [lib/domain/use_cases/channel_details/channel_videos/channel_videos_use_case.dart](/lib/domain/use_cases/channel_details/channel_videos/channel_videos_use_case.dart) | Dart | -2 | 0 | 0 | -2 |
| [lib/domain/use_cases/channel_details/delete_subscription_use_case.dart](/lib/domain/use_cases/channel_details/delete_subscription_use_case.dart) | Dart | -2 | 0 | 0 | -2 |
| [lib/domain/use_cases/channel_details/my_subscriptions_channels_use_case.dart](/lib/domain/use_cases/channel_details/my_subscriptions_channels_use_case.dart) | Dart | -2 | 0 | 0 | -2 |
| [lib/domain/use_cases/channel_details/subscribe_to_channel_use_case.dart](/lib/domain/use_cases/channel_details/subscribe_to_channel_use_case.dart) | Dart | -1 | 0 | 0 | -1 |
| [lib/domain/use_cases/search_details/suggestion_search_texts_use_case.dart](/lib/domain/use_cases/search_details/suggestion_search_texts_use_case.dart) | Dart | 20 | 0 | 5 | 25 |
| [lib/domain/use_cases/videos_details/most_popular_videos_use_case.dart](/lib/domain/use_cases/videos_details/most_popular_videos_use_case.dart) | Dart | 6 | 0 | 2 | 8 |
| [lib/main.dart](/lib/presentation/main.dart) | Dart | -6 | 0 | 5 | -1 |
| [lib/presentation/common_widgets/circular_profile_image.dart](/lib/presentation/common_widgets/circular_profile_image.dart) | Dart | 9 | 0 | 1 | 10 |
| [lib/presentation/common_widgets/mini_player_video.dart](/lib/presentation/common_widgets/mini_player_video/mini_player_video.dart) | Dart | 24 | 0 | 1 | 25 |
| [lib/presentation/common_widgets/moved_thumbnail_video.dart](/lib/presentation/common_widgets/moved_thumbnail_video.dart) | Dart | -110 | 0 | -7 | -117 |
| [lib/presentation/common_widgets/small_thumbnail_video.dart](/lib/presentation/common_widgets/small_thumbnail_video.dart) | Dart | -22 | 0 | -3 | -25 |
| [lib/presentation/common_widgets/thumbnail_image.dart](/lib/presentation/common_widgets/thumbnail_image.dart) | Dart | 39 | 0 | 4 | 43 |
| [lib/presentation/common_widgets/thumbnail_of_video.dart](/lib/presentation/common_widgets/thumbnail_of_video.dart) | Dart | 116 | 0 | 7 | 123 |
| [lib/presentation/cubit/channel/channel_details_cubit.dart](/lib/presentation/cubit/channel/channel_details_cubit.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/presentation/cubit/channel/channel_details_cubit.freezed.dart](/lib/presentation/cubit/channel/channel_details_cubit.freezed.dart) | Dart | 184 | 3 | 12 | 199 |
| [lib/presentation/cubit/channel/channel_videos/channel_videos_cubit.dart](/lib/presentation/cubit/channel/channel_videos/channel_videos_cubit.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/presentation/cubit/channel/channel_videos/channel_videos_cubit.freezed.dart](/lib/presentation/cubit/channel/channel_videos/channel_videos_cubit.freezed.dart) | Dart | -8 | 0 | -2 | -10 |
| [lib/presentation/cubit/channel/playlist/play_list_cubit.dart](/lib/presentation/cubit/channel/playlist/play_list_cubit.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/presentation/cubit/channel/playlist/play_list_cubit.freezed.dart](/lib/presentation/cubit/channel/playlist/play_list_cubit.freezed.dart) | Dart | -8 | 0 | -2 | -10 |
| [lib/presentation/cubit/channel/playlist/play_list_state.dart](/lib/presentation/cubit/channel/playlist/play_list_state.dart) | Dart | -1 | 0 | -1 | -2 |
| [lib/presentation/cubit/search/search_cubit.dart](/lib/presentation/cubit/search/search_cubit.dart) | Dart | 14 | 0 | 4 | 18 |
| [lib/presentation/cubit/search/search_cubit.freezed.dart](/lib/presentation/cubit/search/search_cubit.freezed.dart) | Dart | 185 | 3 | 16 | 204 |
| [lib/presentation/cubit/search/search_state.dart](/lib/presentation/cubit/search/search_state.dart) | Dart | 3 | 0 | 1 | 4 |
| [lib/presentation/cubit/single_video/single_video_cubit.dart](/lib/presentation/cubit/single_video/single_video_cubit.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/presentation/cubit/single_video/single_video_cubit.freezed.dart](/lib/presentation/cubit/single_video/single_video_cubit.freezed.dart) | Dart | -8 | 0 | -2 | -10 |
| [lib/presentation/cubit/videos/popular_videos/popular_videos_cubit.dart](/lib/presentation/cubit/videos/popular_videos/popular_videos_cubit.dart) | Dart | 54 | 0 | 18 | 72 |
| [lib/presentation/cubit/videos/popular_videos/popular_videos_cubit.freezed.dart](/lib/presentation/cubit/videos/popular_videos/popular_videos_cubit.freezed.dart) | Dart | 1,201 | 33 | 127 | 1,361 |
| [lib/presentation/cubit/videos/popular_videos/popular_videos_state.dart](/lib/presentation/cubit/videos/popular_videos/popular_videos_state.dart) | Dart | 16 | 0 | 8 | 24 |
| [lib/presentation/cubit/videos/videos_details_cubit.dart](/lib/presentation/cubit/videos/videos_details_cubit.dart) | Dart | -14 | 0 | -2 | -16 |
| [lib/presentation/cubit/videos/videos_details_cubit.freezed.dart](/lib/presentation/cubit/videos/videos_details_cubit.freezed.dart) | Dart | -8 | 0 | -2 | -10 |
| [lib/presentation/pages/channel_profile/tab_bar_views/home_view.dart](/lib/presentation/pages/channel_profile/tab_bar_views/home_view.dart) | Dart | 8 | 0 | 2 | 10 |
| [lib/presentation/pages/channel_profile/tab_bar_views/videos_view.dart](/lib/presentation/pages/channel_profile/tab_bar_views/videos_view.dart) | Dart | 5 | 0 | 2 | 7 |
| [lib/presentation/pages/channel_profile/user_profile_page.dart](/lib/presentation/pages/channel_profile/user_profile_page.dart) | Dart | 47 | 0 | 4 | 51 |
| [lib/presentation/pages/home/sub_views/most_popular_videos_page.dart](/lib/presentation/pages/home/sub_views/most_popular_videos_page.dart) | Dart | 265 | 0 | 25 | 290 |
| [lib/presentation/pages/home/views/home_page.dart](/lib/presentation/pages/home/views/home_page.dart) | Dart | 136 | 0 | 15 | 151 |
| [lib/presentation/pages/home/views/video_view_page/video_view_page.dart](/lib/presentation/pages/home/views/video_view_page/video_view_page.dart) | Dart | -13 | 0 | -3 | -16 |
| [lib/presentation/pages/search/search_page.dart](/lib/presentation/pages/search/search_page.dart) | Dart | 17 | 0 | 1 | 18 |
| [lib/presentation/pages/search/searched_results_page.dart](/lib/presentation/pages/search/searched_results_page.dart) | Dart | 29 | 1 | 3 | 33 |
| [lib/presentation/pages/search/widgets/searched_text_field.dart](/lib/presentation/pages/search/widgets/searched_text_field.dart) | Dart | 5 | 0 | 0 | 5 |
| [lib/try.dart](/lib/try.dart) | Dart | 0 | -458 | 0 | -458 |
| [macos/Flutter/GeneratedPluginRegistrant.swift](/macos/Flutter/GeneratedPluginRegistrant.swift) | Swift | 4 | 0 | 0 | 4 |
| [pubspec.yaml](/pubspec.yaml) | YAML | 3 | 3 | 0 | 6 |

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details