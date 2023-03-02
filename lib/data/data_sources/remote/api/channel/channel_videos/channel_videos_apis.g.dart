// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_videos_apis.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ChannelVideosAPIs implements ChannelVideosAPIs {
  _ChannelVideosAPIs(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://www.googleapis.com/youtube/v3/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<SearchedVideosDetails> getAllChannelVideosIds({
    apiKey = apiKey,
    required channelId,
    orderVideos = "date",
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': apiKey,
      r'channelId': channelId,
      r'order': orderVideos,
    };
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
              'search?part=snippet&type=video&maxResults=2&videoDuration=long&videoDuration=medium',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchedVideosDetails.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SearchedVideosDetails> getAllChannelShortVideosIds({
    apiKey = apiKey,
    required channelId,
    orderVideos = "date",
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': apiKey,
      r'channelId': channelId,
      r'order': orderVideos,
    };
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
              'search?part=snippet&type=video&maxResults=2&videoDuration=1',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchedVideosDetails.fromJson(_result.data!);
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
