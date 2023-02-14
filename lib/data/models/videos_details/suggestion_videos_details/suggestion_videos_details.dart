import 'package:json_annotation/json_annotation.dart';
import 'package:youtube/data/models/common/base_snippet/base_snippet.dart';
part 'searched_videos_details.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class SuggestionVideosDetails {
  List<SearchedVideosItem?>? items;

  SuggestionVideosDetails({this.items});

  factory SuggestionVideosDetails.fromJson(Map<String, dynamic> json) =>
      _$SearchedVideosDetailsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class SearchedVideosItem {
  SearchedVideosId? id;
  BaseSnippet? snippet;

  SearchedVideosItem({this.id, this.snippet});

  factory SearchedVideosItem.fromJson(Map<String, dynamic> json) =>
      _$SearchedVideosItemFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class SearchedVideosId {
  String? kind;
  String? videoId;

  SearchedVideosId({this.kind, this.videoId});

  factory SearchedVideosId.fromJson(Map<String, dynamic> json) =>
      _$SearchedVideosIdFromJson(json);
}
