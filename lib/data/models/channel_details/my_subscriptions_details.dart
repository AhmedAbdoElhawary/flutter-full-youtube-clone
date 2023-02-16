import 'package:json_annotation/json_annotation.dart';
import 'package:youtube/data/models/common/page_info/page_info.dart';
import 'package:youtube/data/models/common/thumbnail_details/max_thumbnail_details.dart';

part 'my_subscriptions_details.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class MySubscriptionsDetails {
  String? nextPageToken;
  PageInfo? pageInfo;
  List<MySubscriptionsItem?>? items;

  MySubscriptionsDetails({this.nextPageToken, this.pageInfo, this.items});

  factory MySubscriptionsDetails.fromJson(Map<String, dynamic> json) =>
      _$MySubscriptionsDetailsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class MySubscriptionsItem {
  String? id;
  MySubscriptionsSnippet? snippet;

  MySubscriptionsItem({this.id, this.snippet});

  factory MySubscriptionsItem.fromJson(Map<String, dynamic> json) =>
      _$MySubscriptionsItemFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class ResourceId {
  String? kind;
  String? channelId;

  ResourceId({this.kind, this.channelId});

  factory ResourceId.fromJson(Map<String, dynamic> json) =>
      _$ResourceIdFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class MySubscriptionsSnippet {
  DateTime? publishedAt;
  String? title;
  String? description;
  ResourceId? resourceId;
  String? channelId;
  MaxThumbnails? thumbnails;

  MySubscriptionsSnippet(
      {this.publishedAt,
      this.title,
      this.description,
      this.resourceId,
      this.channelId,
      this.thumbnails});

  factory MySubscriptionsSnippet.fromJson(Map<String, dynamic> json) =>
      _$MySubscriptionsSnippetFromJson(json);
}
