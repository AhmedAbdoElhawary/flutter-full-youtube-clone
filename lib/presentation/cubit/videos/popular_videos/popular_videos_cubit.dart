import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/core/functions/api_result.dart';

import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/use_cases/videos_details/most_popular_videos_use_case.dart';

part 'popular_videos_state.dart';
part 'popular_videos_cubit.freezed.dart';

class PopularVideosCubit extends Cubit<PopularVideosState> {
  final MostPopularVideosUseCase _mostPopularVideosUseCase;

  PopularVideosCubit(this._mostPopularVideosUseCase)
      : super(const PopularVideosState.initial());

  static PopularVideosCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> getMostPopularVideos() async {
    emit(const PopularVideosState.loading());

    ApiResult<VideosDetails> result = await _mostPopularVideosUseCase.call(
        params: MostPopularVideosUseCasePar());

    result.when(
        success: (mostPopularVideos) =>
            emit(PopularVideosState.mostPopularVideosLoaded(mostPopularVideos)),
        failure: (exception) => emit(PopularVideosState.error(exception)));
  }

  Future<void> getMostPopularMusicVideos() async {
    emit(const PopularVideosState.loading());

    ApiResult<VideosDetails> result = await _mostPopularVideosUseCase.call(
        params: MostPopularVideosUseCasePar(popularVideoCategoryId: "10"));

    result.when(
        success: (mostPopularVideos) => emit(
            PopularVideosState.mostPopularMusicVideosLoaded(mostPopularVideos)),
        failure: (exception) => emit(PopularVideosState.error(exception)));
  }

  Future<void> getMostPopularGamingVideos() async {
    emit(const PopularVideosState.loading());

    ApiResult<VideosDetails> result = await _mostPopularVideosUseCase.call(
        params: MostPopularVideosUseCasePar(popularVideoCategoryId: "20"));

    result.when(
        success: (mostPopularVideos) => emit(
            PopularVideosState.mostPopularGamingVideosLoaded(
                mostPopularVideos)),
        failure: (exception) => emit(PopularVideosState.error(exception)));
  }

  Future<void> getMostPopularMoviesVideos() async {
    emit(const PopularVideosState.loading());

    ApiResult<VideosDetails> result = await _mostPopularVideosUseCase.call(
        params: MostPopularVideosUseCasePar(popularVideoCategoryId: "44"));

    result.when(
        success: (mostPopularVideos) => emit(
            PopularVideosState.mostPopularMoviesVideosLoaded(
                mostPopularVideos)),
        failure: (exception) => emit(PopularVideosState.error(exception)));
  }
}