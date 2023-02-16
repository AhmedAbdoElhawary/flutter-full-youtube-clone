import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/core/functions/api_result.dart';

import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/use_cases/search_details/related_videos_to_this_video_use_case.dart';
import 'package:youtube/domain/use_cases/search_details/search_for_this_sentence_use_case.dart';

part 'search_state.dart';
part 'search_cubit.freezed.dart';

class SearchCubit extends Cubit<SearchState> {
  final RelatedVideosToThisVideoUseCase _relatedVideosToThisVideoUseCase;
  final SearchForThisSentenceUseCase _searchForThisSentenceUseCase;

  SearchCubit(
    this._relatedVideosToThisVideoUseCase,
    this._searchForThisSentenceUseCase,
  ) : super(const SearchState.initial());

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> searchForThisSentence(String sentence) async {
    emit(const SearchState.loading());

    ApiResult<VideosDetails> result = await _searchForThisSentenceUseCase.call(
        params: SearchForThisSentenceUseCasePara(sentence: sentence));

    result.when(
        success: (videoDetails) =>
            emit(SearchState.searchForTheSentenceLoaded(videoDetails)),
        failure: (exception) => emit(SearchState.error(exception)));
  }

  Future<void> relatedVideosToThisVideo(String relatedToVideoId) async {
    emit(const SearchState.loading());

    ApiResult<VideosDetails> result =
        await _relatedVideosToThisVideoUseCase.call(
            params: RelatedVideosToThisVideoUseCasePara(
                relatedToVideoId: relatedToVideoId));

    result.when(
        success: (videoDetails) =>
            emit(SearchState.relatedVideosLoaded(videoDetails)),
        failure: (exception) => emit(SearchState.error(exception)));
  }
}
