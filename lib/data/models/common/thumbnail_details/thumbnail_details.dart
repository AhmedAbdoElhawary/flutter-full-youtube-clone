import 'package:json_annotation/json_annotation.dart';

part 'thumbnail_details.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class ThumbnailDetails {
  ThumbnailDetails(this.url, this.width, this.height);

  String? url;
  int? width;
  int? height;

  factory ThumbnailDetails.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailDetailsFromJson(json);
}
