// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_playlist_apis.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ChannelPlayListAPIs implements ChannelPlayListAPIs {
  _ChannelPlayListAPIs(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://www.googleapis.com/youtube/v3/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PlayLists> getChannelPlayLists({
    String apiKey = apiKey,
    required String channelId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': apiKey,
      r'channelId': channelId,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<PlayLists>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'playlists?part=snippet,contentDetails,status&maxResults=50',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PlayLists.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PlayLists> getMyPlayLists({
    String apiKey = apiKey,
    required String accessToken,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': apiKey,
      r'access_token': accessToken,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<PlayLists>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'playlists?part=snippet,contentDetails,status&maxResults=50&mine=true',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PlayLists.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PlayListVideos> getChannelPlayListItemsIds({
    String apiKey = apiKey,
    required String playlistId,
    required String accessToken,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': apiKey,
      r'playlistId': playlistId,
      r'access_token': accessToken,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<PlayListVideos>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'playlistItems?part=contentDetails&maxResults=50',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PlayListVideos.fromJson(_result.data!);
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
