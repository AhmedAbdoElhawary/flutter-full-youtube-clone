import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_details.g.dart';

@JsonSerializable(includeIfNull: true)
class VideoDetails {
  VideoDetails(this.kind, this.tag, this.videoDetailsItem);

  String? kind;
  @JsonKey(name: "etag")
  String? tag;
  @JsonKey(name: "items")
  List<VideoDetailsItem>? videoDetailsItem;
  factory VideoDetails.fromJson(Map<String, dynamic> json) =>
      _$VideoDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$VideoDetailsToJson(this);
}

@JsonSerializable(includeIfNull: true)
class VideoDetailsItem {
  VideoDetailsItem(
    this.kind,
    this.tag,
    this.id,
    this.snippet,
    this.contentDetails,
    this.statistics,
  );

  String? kind;
  @JsonKey(name: "etag")
  String? tag;
  String? id;
  Snippet? snippet;
  ContentDetails contentDetails;
  Statistics statistics;

  factory VideoDetailsItem.fromJson(Map<String, dynamic> json) => _$VideoDetailsItemFromJson(json);

  Map<String, dynamic> toJson() => _$VideoDetailsItemToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Snippet {
  Snippet(
    this.publishedAt,
    this.channelId,
    this.title,
    this.description,
    this.thumbnails,
    this.channelTitle,
    this.tags,
    this.categoryId,
    this.liveBroadcastContent,
    this.defaultLanguage,
    this.localized,
    this.defaultAudioLanguage,
  );

  DateTime? publishedAt;
  String? channelId;
  String? title;
  String? description;
  Thumbnails? thumbnails;
  String? channelTitle;
  List<String>? tags;
  String? categoryId;
  String? liveBroadcastContent;
  String? defaultLanguage;
  Localized? localized;
  String? defaultAudioLanguage;

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Localized {
  Localized(this.title, this.description);

  String? title;
  String? description;

  factory Localized.fromJson(Map<String, dynamic> json) =>
      _$LocalizedFromJson(json);

  Map<String, dynamic> toJson() => _$LocalizedToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Thumbnails {
  Thumbnails(
      this.thumbnailsDefault, this.medium, this.high, this.standard, this.max);

  Default? thumbnailsDefault;
  Default? medium;
  Default? high;
  Default? standard;

  @JsonKey(name: "maxres")
  Default? max;

  factory Thumbnails.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailsFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailsToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Default {
  Default(this.url, this.width, this.height);

  String? url;
  int? width;
  int? height;

  factory Default.fromJson(Map<String, dynamic> json) =>
      _$DefaultFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultToJson(this);
}

@JsonSerializable(includeIfNull: true)
class PageInfo {
  PageInfo(this.totalResults, this.resultsPerPage);

  int? totalResults;
  int? resultsPerPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      _$PageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PageInfoToJson(this);
}

@JsonSerializable(includeIfNull: true)
class ContentDetails {
  ContentDetails(
    this.duration,
    this.dimension,
    this.definition,
    this.caption,
    this.licensedContent,
    this.projection,
  );

  String? duration;
  String? dimension;
  String? definition;
  String? caption;
  bool? licensedContent;
  String? projection;

  factory ContentDetails.fromJson(Map<String, dynamic> json) =>
      _$ContentDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ContentDetailsToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Statistics {
  Statistics(
    this.viewCount,
    this.favoriteCount,
    this.commentCount,
    this.likeCount,
  );

  String? viewCount;
  String? favoriteCount;
  String? commentCount;
  String? likeCount;

  factory Statistics.fromJson(Map<String, dynamic> json) =>
      _$StatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsToJson(this);
}
