import 'package:json_annotation/json_annotation.dart';
import 'package:youtube/data/models/common/base_snippet/base_snippet.dart';
import 'package:youtube/data/models/common/page_info/page_info.dart';

part 'playlists.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class PlayLists {
  PageInfo? pageInfo;
  List<PlayListsItem?>? items;

  PlayLists({this.pageInfo, this.items});

  factory PlayLists.fromJson(Map<String, dynamic> json) =>
      _$PlayListsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class PlayListsItem {
  String? id;
  BaseSnippet? snippet;
  PlayListContentDetails? contentDetails;

  @JsonKey(includeToJson: false, includeFromJson: false)
  String? blurHash;

  PlayListsItem({this.id, this.snippet, this.contentDetails});

  factory PlayListsItem.fromJson(Map<String, dynamic> json) =>
      _$PlayListsItemFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class PlayListContentDetails {
  int? itemCount;

  PlayListContentDetails({this.itemCount});

  factory PlayListContentDetails.fromJson(Map<String, dynamic> json) =>
      _$PlayListContentDetailsFromJson(json);
}
