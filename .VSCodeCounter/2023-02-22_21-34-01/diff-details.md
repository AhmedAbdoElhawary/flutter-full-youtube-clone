# Diff Details

Date : 2023-02-22 21:34:01

Directory d:\\flutter_projects\\main\\youtube-flutter-clone

Total : 60 files,  3751 codes, 213 comments, 473 blanks, all 4437 lines

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [assets/icons/close.svg](/assets/icons/close.svg) | XML | -5 | 0 | -1 | -6 |
| [assets/icons/like.svg](/assets/icons/like.svg) | XML | 1 | 0 | 0 | 1 |
| [assets/icons/plus-circle.svg](/assets/icons/plus-circle.svg) | XML | 7 | 0 | 1 | 8 |
| [assets/icons/search.svg](/assets/icons/search.svg) | XML | 1 | 0 | 0 | 1 |
| [lib/core/functions/reformat/views_reformat.dart](/lib/core/functions/reformat/views_reformat.dart) | Dart | 2 | 0 | 1 | 3 |
| [lib/data/data_sources/remote/api/videos/videos_apis.dart](/lib/data/data_sources/remote/api/videos/videos_apis.dart) | Dart | 1 | 0 | 0 | 1 |
| [lib/data/models/channel_details/channel_details.dart](/lib/data/models/channel_details/channel_details.dart) | Dart | 12 | 0 | 1 | 13 |
| [lib/data/models/channel_details/channel_details.g.dart](/lib/data/models/channel_details/channel_details.g.dart) | Dart | 3 | 0 | 0 | 3 |
| [lib/data/models/channel_details/channel_sub_details/channel_sub_details_extension.dart](/lib/data/models/channel_details/channel_sub_details/channel_sub_details_extension.dart) | Dart | 2 | 0 | 1 | 3 |
| [lib/data/models/videos_details/video_details_extension.dart](/lib/data/models/videos_details/video_details_extension.dart) | Dart | 9 | 0 | -1 | 8 |
| [lib/data/repositories_impl/channel/channel_details_repo_impl.dart](/lib/data/repositories_impl/channel/channel_details_repo_impl.dart) | Dart | -3 | 0 | 0 | -3 |
| [lib/data/repositories_impl/search_details_repo_impl.dart](/lib/data/repositories_impl/search_details_repo_impl.dart) | Dart | -46 | -1 | 0 | -47 |
| [lib/data/repositories_impl/videos_details_repo_impl.dart](/lib/data/repositories_impl/videos_details_repo_impl.dart) | Dart | -3 | 0 | 0 | -3 |
| [lib/main.dart](/lib/main.dart) | Dart | -6 | 8 | -2 | 0 |
| [lib/presentation/common_widgets/circular_profile_image.dart](/lib/presentation/common_widgets/circular_profile_image.dart) | Dart | 17 | 0 | 3 | 20 |
| [lib/presentation/common_widgets/custom_network_display.dart](/lib/presentation/common_widgets/custom_network_display.dart) | Dart | 40 | 0 | 6 | 46 |
| [lib/presentation/common_widgets/mini_player_video.dart](/lib/presentation/common_widgets/mini_player_video/mini_player_video.dart) | Dart | 17 | 5 | -1 | 21 |
| [lib/presentation/common_widgets/thumbnail_image.dart](/lib/presentation/common_widgets/thumbnail_image.dart) | Dart | 7 | 0 | 2 | 9 |
| [lib/presentation/custom_packages/custom_mini_player/custom_mini_player.dart](/lib/presentation/custom_packages/custom_mini_player/custom_mini_player.dart) | Dart | 319 | 36 | 79 | 434 |
| [lib/presentation/custom_packages/custom_mini_player/mini_player_will_pop_scope.dart](/lib/presentation/custom_packages/custom_mini_player/mini_player_will_pop_scope.dart) | Dart | 54 | 0 | 13 | 67 |
| [lib/presentation/custom_packages/custom_mini_player/utils.dart](/lib/presentation/custom_packages/custom_mini_player/utils.dart) | Dart | 27 | 1 | 5 | 33 |
| [lib/presentation/custom_packages/pod_player/pod_player.dart](/lib/presentation/custom_packages/pod_player/pod_player.dart) | Dart | 12 | 0 | 3 | 15 |
| [lib/presentation/custom_packages/pod_player/src/controllers/pod_base_controller.dart](/lib/presentation/custom_packages/pod_player/src/controllers/pod_base_controller.dart) | Dart | 86 | 8 | 22 | 116 |
| [lib/presentation/custom_packages/pod_player/src/controllers/pod_gestures_controller.dart](/lib/presentation/custom_packages/pod_player/src/controllers/pod_gestures_controller.dart) | Dart | 69 | 3 | 12 | 84 |
| [lib/presentation/custom_packages/pod_player/src/controllers/pod_getx_video_controller.dart](/lib/presentation/custom_packages/pod_player/src/controllers/pod_getx_video_controller.dart) | Dart | 253 | 17 | 34 | 304 |
| [lib/presentation/custom_packages/pod_player/src/controllers/pod_player_controller.dart](/lib/presentation/custom_packages/pod_player/src/controllers/pod_player_controller.dart) | Dart | 171 | 46 | 52 | 269 |
| [lib/presentation/custom_packages/pod_player/src/controllers/pod_ui_controller.dart](/lib/presentation/custom_packages/pod_player/src/controllers/pod_ui_controller.dart) | Dart | 11 | 3 | 5 | 19 |
| [lib/presentation/custom_packages/pod_player/src/controllers/pod_video_controller.dart](/lib/presentation/custom_packages/pod_player/src/controllers/pod_video_controller.dart) | Dart | 214 | 16 | 28 | 258 |
| [lib/presentation/custom_packages/pod_player/src/controllers/pod_video_quality_controller.dart](/lib/presentation/custom_packages/pod_player/src/controllers/pod_video_quality_controller.dart) | Dart | 102 | 13 | 20 | 135 |
| [lib/presentation/custom_packages/pod_player/src/models/overlay_options.dart](/lib/presentation/custom_packages/pod_player/src/models/overlay_options.dart) | Dart | 29 | 0 | 2 | 31 |
| [lib/presentation/custom_packages/pod_player/src/models/play_video_from.dart](/lib/presentation/custom_packages/pod_player/src/models/play_video_from.dart) | Dart | 133 | 2 | 8 | 143 |
| [lib/presentation/custom_packages/pod_player/src/models/pod_player_config.dart](/lib/presentation/custom_packages/pod_player/src/models/pod_player_config.dart) | Dart | 29 | 5 | 4 | 38 |
| [lib/presentation/custom_packages/pod_player/src/models/pod_player_labels.dart](/lib/presentation/custom_packages/pod_player/src/models/pod_player_labels.dart) | Dart | 30 | 1 | 2 | 33 |
| [lib/presentation/custom_packages/pod_player/src/models/pod_progress_bar_config.dart](/lib/presentation/custom_packages/pod_player/src/models/pod_progress_bar_config.dart) | Dart | 89 | 15 | 20 | 124 |
| [lib/presentation/custom_packages/pod_player/src/models/vimeo_models.dart](/lib/presentation/custom_packages/pod_player/src/models/vimeo_models.dart) | Dart | 10 | 0 | 2 | 12 |
| [lib/presentation/custom_packages/pod_player/src/pod_player.dart](/lib/presentation/custom_packages/pod_player/src/pod_player.dart) | Dart | 218 | 15 | 23 | 256 |
| [lib/presentation/custom_packages/pod_player/src/utils/enums.dart](/lib/presentation/custom_packages/pod_player/src/utils/enums.dart) | Dart | 15 | 0 | 2 | 17 |
| [lib/presentation/custom_packages/pod_player/src/utils/logger.dart](/lib/presentation/custom_packages/pod_player/src/utils/logger.dart) | Dart | 4 | 0 | 3 | 7 |
| [lib/presentation/custom_packages/pod_player/src/utils/video_apis.dart](/lib/presentation/custom_packages/pod_player/src/utils/video_apis.dart) | Dart | 116 | 1 | 7 | 124 |
| [lib/presentation/custom_packages/pod_player/src/widgets/animated_play_pause_icon.dart](/lib/presentation/custom_packages/pod_player/src/widgets/animated_play_pause_icon.dart) | Dart | 89 | 1 | 10 | 100 |
| [lib/presentation/custom_packages/pod_player/src/widgets/core/overlays/mobile_bottomsheet.dart](/lib/presentation/custom_packages/pod_player/src/widgets/core/overlays/mobile_bottomsheet.dart) | Dart | 275 | 0 | 17 | 292 |
| [lib/presentation/custom_packages/pod_player/src/widgets/core/overlays/mobile_overlay.dart](/lib/presentation/custom_packages/pod_player/src/widgets/core/overlays/mobile_overlay.dart) | Dart | 178 | 0 | 9 | 187 |
| [lib/presentation/custom_packages/pod_player/src/widgets/core/overlays/overlays.dart](/lib/presentation/custom_packages/pod_player/src/widgets/core/overlays/overlays.dart) | Dart | 64 | 4 | 5 | 73 |
| [lib/presentation/custom_packages/pod_player/src/widgets/core/overlays/web_dropdown_menu.dart](/lib/presentation/custom_packages/pod_player/src/widgets/core/overlays/web_dropdown_menu.dart) | Dart | 188 | 2 | 9 | 199 |
| [lib/presentation/custom_packages/pod_player/src/widgets/core/overlays/web_overlay.dart](/lib/presentation/custom_packages/pod_player/src/widgets/core/overlays/web_overlay.dart) | Dart | 208 | 0 | 8 | 216 |
| [lib/presentation/custom_packages/pod_player/src/widgets/core/pod_core_player.dart](/lib/presentation/custom_packages/pod_player/src/widgets/core/pod_core_player.dart) | Dart | 162 | 12 | 6 | 180 |
| [lib/presentation/custom_packages/pod_player/src/widgets/core/video_gesture_detector.dart](/lib/presentation/custom_packages/pod_player/src/widgets/core/video_gesture_detector.dart) | Dart | 29 | 0 | 5 | 34 |
| [lib/presentation/custom_packages/pod_player/src/widgets/full_screen_view.dart](/lib/presentation/custom_packages/pod_player/src/widgets/full_screen_view.dart) | Dart | 81 | 0 | 10 | 91 |
| [lib/presentation/custom_packages/pod_player/src/widgets/material_icon_button.dart](/lib/presentation/custom_packages/pod_player/src/widgets/material_icon_button.dart) | Dart | 44 | 1 | 3 | 48 |
| [lib/presentation/custom_packages/pod_player/src/widgets/pod_progress_bar.dart](/lib/presentation/custom_packages/pod_player/src/widgets/pod_progress_bar.dart) | Dart | 238 | 1 | 25 | 264 |
| [lib/presentation/pages/channel_profile/channel_profile_logic.dart](/lib/presentation/pages/channel_profile/channel_profile_logic.dart) | Dart | 7 | 0 | 4 | 11 |
| [lib/presentation/pages/channel_profile/profile_page.dart](/lib/presentation/pages/channel_profile/profile_page.dart) | Dart | 5 | 0 | 1 | 6 |
| [lib/presentation/pages/channel_profile/tab_bar_views/about_view.dart](/lib/presentation/pages/channel_profile/tab_bar_views/about_view.dart) | Dart | 63 | 0 | 2 | 65 |
| [lib/presentation/pages/channel_profile/tab_bar_views/home_view.dart](/lib/presentation/pages/channel_profile/tab_bar_views/home_view.dart) | Dart | 20 | 0 | 0 | 20 |
| [lib/presentation/pages/channel_profile/tab_bar_views/videos_horizontal_descriptions_list.dart](/lib/presentation/pages/channel_profile/tab_bar_views/videos_horizontal_descriptions_list.dart) | Dart | 4 | 0 | -1 | 3 |
| [lib/presentation/pages/channel_profile/tab_bar_views/videos_view.dart](/lib/presentation/pages/channel_profile/tab_bar_views/videos_view.dart) | Dart | 72 | 0 | 10 | 82 |
| [lib/presentation/pages/channel_profile/user_profile_page.dart](/lib/presentation/pages/channel_profile/user_profile_page.dart) | Dart | 14 | -1 | 0 | 13 |
| [lib/presentation/pages/home/logic/home_page_logic.dart](/lib/presentation/pages/home/logic/home_page_logic.dart) | Dart | -40 | 0 | -5 | -45 |
| [lib/presentation/pages/search/searched_results_page.dart](/lib/presentation/pages/search/searched_results_page.dart) | Dart | -1 | 0 | 0 | -1 |
| [pubspec.yaml](/pubspec.yaml) | YAML | 4 | -1 | -1 | 2 |

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details