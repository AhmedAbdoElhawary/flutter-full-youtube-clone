import 'package:json_annotation/json_annotation.dart';

part 'comment_body.g.dart';

@JsonSerializable(includeIfNull: true)
class CommentBody {
  final CommentBodySnippet snippet;

  CommentBody({required this.snippet});

  factory CommentBody.fromJson(Map<String, dynamic> json) =>
      _$CommentBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CommentBodyToJson(this);
}

@JsonSerializable(includeIfNull: true)
class CommentBodySnippet {
  final String videoId;
  final String textOriginal;
  final String parentId;

  CommentBodySnippet(
      {required this.videoId,
      required this.parentId,
      required this.textOriginal});

  factory CommentBodySnippet.fromJson(Map<String, dynamic> json) =>
      _$CommentBodySnippetFromJson(json);

  Map<String, dynamic> toJson() => _$CommentBodySnippetToJson(this);
}
