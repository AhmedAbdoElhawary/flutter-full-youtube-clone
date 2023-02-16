// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_subscriptions_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MySubscriptionsDetails _$MySubscriptionsDetailsFromJson(
        Map<String, dynamic> json) =>
    MySubscriptionsDetails(
      nextPageToken: json['nextPageToken'] as String?,
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : MySubscriptionsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

MySubscriptionsItem _$MySubscriptionsItemFromJson(Map<String, dynamic> json) =>
    MySubscriptionsItem(
      id: json['id'] as String?,
      snippet: json['snippet'] == null
          ? null
          : MySubscriptionsSnippet.fromJson(
              json['snippet'] as Map<String, dynamic>),
    );

ResourceId _$ResourceIdFromJson(Map<String, dynamic> json) => ResourceId(
      kind: json['kind'] as String?,
      channelId: json['channelId'] as String?,
    );

MySubscriptionsSnippet _$MySubscriptionsSnippetFromJson(
        Map<String, dynamic> json) =>
    MySubscriptionsSnippet(
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      title: json['title'] as String?,
      description: json['description'] as String?,
      resourceId: json['resourceId'] == null
          ? null
          : ResourceId.fromJson(json['resourceId'] as Map<String, dynamic>),
      channelId: json['channelId'] as String?,
      thumbnails: json['thumbnails'] == null
          ? null
          : MaxThumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
    );
