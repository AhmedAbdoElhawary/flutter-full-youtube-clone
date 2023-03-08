import 'package:json_annotation/json_annotation.dart';
import 'package:youtube/data/models/common/base_snippet/base_snippet.dart';
import 'package:youtube/data/models/common/page_info/page_info.dart';

part 'playlists.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class PlayLists {
  PageInfo? pageInfo;
  List<PlayListItem?>? items;

  PlayLists({this.pageInfo, this.items});

  factory PlayLists.fromJson(Map<String, dynamic> json) =>
      _$PlayListsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class PlayListItem {
  String? id;
  BaseSnippet? snippet;
  PlayListContentDetails? contentDetails;
  PlayListStatus? status;


  PlayListItem({this.id, this.snippet, this.contentDetails});

  factory PlayListItem.fromJson(Map<String, dynamic> json) =>
      _$PlayListItemFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class PlayListContentDetails {
  int? itemCount;

  PlayListContentDetails({this.itemCount});

  factory PlayListContentDetails.fromJson(Map<String, dynamic> json) =>
      _$PlayListContentDetailsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class PlayListStatus {
  String? privacyStatus;

  PlayListStatus({this.privacyStatus});

  factory PlayListStatus.fromJson(Map<String, dynamic> json) =>
      _$PlayListStatusFromJson(json);
}
