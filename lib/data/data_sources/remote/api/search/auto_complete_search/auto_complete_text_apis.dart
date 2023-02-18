import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:youtube/data/models/suggestion_texts/suggestion_texts.dart';

class SuggestionSearchTextAPIs {
  final Dio _dio;

  SuggestionSearchTextAPIs(this._dio);

  Future<SuggestionTexts> getSuggestionTexts(String text) async {
    final response = await _dio.get(
      'https://suggestqueries.google.com/complete/search',
      queryParameters: {
        'client': 'firefox',
        'q': text,
      },
    );

    final json = jsonDecode(response.toString());
    final searchResult = SuggestionTexts.fromJson(json);

    return searchResult;
  }
}
