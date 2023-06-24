import 'package:json_annotation/json_annotation.dart';
import 'package:youtube/data/models/common/thumbnail_details/max_thumbnail_details.dart';

part 'base_snippet.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class BaseSnippet {
  DateTime? publishedAt;
  String? channelId;
  String? title;
  String? description;
  MaxThumbnails? thumbnails;
  String? channelTitle;

  BaseSnippet(
      {this.publishedAt,
      this.channelId,
      this.title,
      this.description,
      this.thumbnails,
      this.channelTitle});

  factory BaseSnippet.fromJson(Map<String, dynamic> json) =>
      _$BaseSnippetFromJson(json);
}
