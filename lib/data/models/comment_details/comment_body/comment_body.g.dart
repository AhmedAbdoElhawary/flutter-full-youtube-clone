// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentBody _$CommentBodyFromJson(Map<String, dynamic> json) => CommentBody(
      snippet:
          CommentBodySnippet.fromJson(json['snippet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentBodyToJson(CommentBody instance) =>
    <String, dynamic>{
      'snippet': instance.snippet,
    };

CommentBodySnippet _$CommentBodySnippetFromJson(Map<String, dynamic> json) =>
    CommentBodySnippet(
      videoId: json['videoId'] as String,
      parentId: json['parentId'] as String,
      textOriginal: json['textOriginal'] as String,
    );

Map<String, dynamic> _$CommentBodySnippetToJson(CommentBodySnippet instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'textOriginal': instance.textOriginal,
      'parentId': instance.parentId,
    };
