import 'package:json_annotation/json_annotation.dart';

part 'author_channel_id.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class AuthorChannelId {
  String? value;

  AuthorChannelId({this.value});

  factory AuthorChannelId.fromJson(Map<String, dynamic> json) =>
      _$AuthorChannelIdFromJson(json);
}
