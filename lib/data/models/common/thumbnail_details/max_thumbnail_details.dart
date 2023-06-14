import 'package:json_annotation/json_annotation.dart';
import 'package:youtube/data/models/common/thumbnail_details/thumbnail_details.dart';
part 'max_thumbnail_details.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class MaxThumbnails {
  MaxThumbnails(
      this.thumbnailsDefault, this.medium, this.high, this.standard, this.max);

  ThumbnailDetails? thumbnailsDefault;
  ThumbnailDetails? medium;
  ThumbnailDetails? high;
  ThumbnailDetails? standard;

  @JsonKey(name: "maxres")
  ThumbnailDetails? max;

  factory MaxThumbnails.fromJson(Map<String, dynamic> json) =>
      _$MaxThumbnailsFromJson(json);
}
