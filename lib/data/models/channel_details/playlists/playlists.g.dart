// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayLists _$PlayListsFromJson(Map<String, dynamic> json) => PlayLists(
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : PlayListsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

PlayListsItem _$PlayListsItemFromJson(Map<String, dynamic> json) =>
    PlayListsItem(
      id: json['id'] as String?,
      snippet: json['snippet'] == null
          ? null
          : BaseSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
      contentDetails: json['contentDetails'] == null
          ? null
          : PlayListContentDetails.fromJson(
              json['contentDetails'] as Map<String, dynamic>),
    );

PlayListContentDetails _$PlayListContentDetailsFromJson(
        Map<String, dynamic> json) =>
    PlayListContentDetails(
      itemCount: json['itemCount'] as int?,
    );
