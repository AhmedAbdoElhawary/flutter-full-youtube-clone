import 'package:json_annotation/json_annotation.dart';

part 'page_info.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class PageInfo {
  int? totalResults;
  int? resultsPerPage;

  PageInfo({this.totalResults, this.resultsPerPage});

  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      _$PageInfoFromJson(json);
}
