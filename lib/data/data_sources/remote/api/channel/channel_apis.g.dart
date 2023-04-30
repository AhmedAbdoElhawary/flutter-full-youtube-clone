// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_apis.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ChannelAPIs implements ChannelAPIs {
  _ChannelAPIs(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://www.googleapis.com/youtube/v3/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ChannelSubDetails> getSubChannelInfo({
    String apiKey = apiKey,
    required String channelId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': apiKey,
      r'id': channelId,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ChannelSubDetails>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'channels?part=brandingSettings,contentDetails,statistics,snippet',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ChannelSubDetails.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ChannelSubDetails> getMyChannelInfo({
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
        .fetch<Map<String, dynamic>>(_setStreamType<ChannelSubDetails>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'channels?part=brandingSettings,contentDetails,statistics,snippet&mine=true',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ChannelSubDetails.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MySubscriptionsDetails> getMySubscriptionsChannels({
    String apiKey = apiKey,
    required String accessToken,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MySubscriptionsDetails>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'subscriptions?part=snippet&mine=true&access_token=${accessToken}&key%20=${apiKey}&maxResults=2',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MySubscriptionsDetails.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> subscribeToChannel({
    String apiKey = apiKey,
    required Map<String, dynamic> body,
    required String accessToken,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': apiKey,
      r'access_token': accessToken,
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'subscriptions?part=snippet',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> deleteSubscription({
    required String id,
    required String accessToken,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'id': id,
      r'access_token': accessToken,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'subscriptions',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
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
