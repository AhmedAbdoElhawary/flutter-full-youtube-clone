import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/presentation/common_widgets/arrow_back.dart';
import 'package:youtube/presentation/common_widgets/error_message_widget.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';
import 'package:youtube/presentation/common_widgets/thumbnail_of_video.dart';
import 'package:youtube/presentation/common_widgets/videos_list_loading.dart';
import 'package:youtube/presentation/cubit/search/search_cubit.dart';
import 'package:youtube/presentation/pages/search/widgets/searched_text_field.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import 'widgets/mic_button.dart';

class SearchedResultsPageParameter {
  final String text;

  SearchedResultsPageParameter({required this.text});
}

class SearchedResultsPage extends StatefulWidget {
  const SearchedResultsPage(this.parameter, {Key? key}) : super(key: key);
  final SearchedResultsPageParameter parameter;

  @override
  State<SearchedResultsPage> createState() => _SearchedResultsPageState();
}

class _SearchedResultsPageState extends State<SearchedResultsPage>
    with AutomaticKeepAliveClientMixin<SearchedResultsPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    TextEditingController controller =
        TextEditingController(text: widget.parameter.text);

    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBack(),
        surfaceTintColor: ColorManager(context).white,
        title: SearchTextField(controller: controller, enableOnTap: true),
        actions: const [
          RSizedBox(width: 15),
          MicIconButton(),
          RSizedBox(width: 20),
          SvgIcon(IconsAssets.menuPointsVerticalIcon,size: 15),
          RSizedBox(width: 20),
        ],
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        bloc: SearchCubit.get(context)
          ..searchForThisSentence(widget.parameter.text),
        builder: (context, state) {
          if (state is SearchForTheSentenceLoaded) {
            return ListView.builder(
                itemBuilder: (context, index) => Padding(
                      padding: REdgeInsets.only(bottom: 15),
                      child: ThumbnailOfVideo(
                          state.videosDetails.videoDetailsItem?[index]),
                    ),
                itemCount: state.videosDetails.videoDetailsItem?.length);
          } else if (state is SearchError) {
            return ErrorMessageWidget(state.networkExceptions);
          } else {
            return const VideosListLoading();
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
