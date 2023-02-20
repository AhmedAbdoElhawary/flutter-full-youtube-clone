// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videos_apis.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _VideosAPIs implements VideosAPIs {
  _VideosAPIs(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://www.googleapis.com/youtube/v3/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<SearchedVideosDetails> getAllVideosIds({apiKey = apiKey}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'key': apiKey};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchedVideosDetails>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'search?part=snippet&maxResults=50&regionCode=EG',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchedVideosDetails.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SearchedVideosDetails> getAllShortVideosIds({apiKey = apiKey}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'key': apiKey};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchedVideosDetails>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'search?part=snippet&maxResults=50&regionCode=EG&videoDuration=short',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchedVideosDetails.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VideosDetails> getVideosOfThoseIds({
    apiKey = apiKey,
    required videosIds,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': apiKey,
      r'id': videosIds,
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<VideosDetails>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'videos?part=contentDetails,statistics,snippet&maxResults=50&regionCode=EG',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VideosDetails.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VideosDetails> getMostPopularVideos({
    apiKey = apiKey,
    required videoCategoryId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': apiKey,
      r'videoCategoryId': videoCategoryId,
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<VideosDetails>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'videos?part=contentDetails,statistics,snippet&chart=mostPopular&maxResults=50&regionCode=EG',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VideosDetails.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
