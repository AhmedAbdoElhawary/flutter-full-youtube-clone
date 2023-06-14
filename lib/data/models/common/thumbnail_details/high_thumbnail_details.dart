import 'package:json_annotation/json_annotation.dart';
import 'package:youtube/data/models/common/thumbnail_details/thumbnail_details.dart';

part 'high_thumbnail_details.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class HighThumbnails {
  ThumbnailDetails? medium;
  ThumbnailDetails? high;

  HighThumbnails(this.medium, this.high);

  factory HighThumbnails.fromJson(Map<String, dynamic> json) =>
      _$HighThumbnailsFromJson(json);
}
