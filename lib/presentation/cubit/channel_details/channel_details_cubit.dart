import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/domain/use_cases/channel_details/channel_sub_details_use_case.dart';

part 'channel_details_state.dart';
part 'channel_details_cubit.freezed.dart';

class ChannelDetailsCubit extends Cubit<ChannelDetailsState> {
  final ChannelSubDetailsUseCase _channelSubDetailsUseCase;

  ChannelDetailsCubit(this._channelSubDetailsUseCase)
      : super(const ChannelDetailsState.initial());

  static ChannelDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> getChannelSubDetails(String channelId) async {
    emit(const ChannelDetailsState.loading());

    ApiResult<ChannelSubDetails> channelSubDetails =
        await _channelSubDetailsUseCase.call(
            params: ChannelSubDetailsUseCaseParameters(channelId: channelId));

    channelSubDetails.when(
        success: (videoDetails) =>
            emit(ChannelDetailsState.channelSubDetailsLoaded(videoDetails)),
        failure: (exception) => emit(ChannelDetailsState.error(exception)));
  }
}
