import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube/domain/use_cases/videos_details/most_popular_videos_use_case.dart';
part 'videos_details_state.dart';
part 'videos_details_cubit.freezed.dart';

class VideosDetailsCubit extends Cubit<VideosDetailsState> {
  final MostPopularVideosUseCase _mostPopularVideosUseCase;

  VideosDetailsCubit(this._mostPopularVideosUseCase)
      : super(const VideosDetailsState.initial());

  static VideosDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> getMostPopularVideos() async {
    emit(const VideosDetailsState.loading());

    ApiResult<VideosDetails> result =
        await _mostPopularVideosUseCase.call(params: null);

    result.when(
        success: (mostPopularVideos) =>
            emit(VideosDetailsState.mostPopularVideosLoaded(mostPopularVideos)),
        failure: (exception) => emit(VideosDetailsState.error(exception)));
  }
}
