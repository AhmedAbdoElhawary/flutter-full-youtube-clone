import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/core/helpers/handling_errors/api_result.dart';
import 'package:youtube/core/helpers/handling_errors/network_exception_model.dart';
import 'package:youtube/data/models/suggestion_texts/suggestion_texts.dart';

import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/use_cases/search_details/search_for_this_sentence_use_case.dart';
import 'package:youtube/domain/use_cases/search_details/suggestion_search_texts_use_case.dart';

part 'search_state.dart';
part 'search_cubit.freezed.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchForThisSentenceUseCase _searchForThisSentenceUseCase;
  final SuggestionSearchTextsUseCase _suggestionSearchTextsUseCase;

  SearchCubit(
    this._searchForThisSentenceUseCase,
    this._suggestionSearchTextsUseCase,
  ) : super(const SearchState.initial());

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> getSuggestionTexts(String text) async {
    emit(const SearchState.searchLoading());

    ApiResult<SuggestionTexts> result = await _suggestionSearchTextsUseCase
        .call(params: SuggestionSearchTextsUseCaseParameter(text: text));

    result.when(
        success: (suggestionTexts) {
          emit(SearchState.suggestionTextsLoaded(suggestionTexts));
        },
        failure: (exception) => emit(SearchState.searchError(exception)));
  }

  Future<void> searchForThisSentence(String sentence) async {
    emit(const SearchState.searchLoading());

    ApiResult<VideosDetails> result = await _searchForThisSentenceUseCase.call(
        params: SearchForThisSentenceUseCasePara(sentence: sentence));

    result.when(
        success: (videoDetails) =>
            emit(SearchState.searchForTheSentenceLoaded(videoDetails)),
        failure: (exception) => emit(SearchState.searchError(exception)));
  }
}
