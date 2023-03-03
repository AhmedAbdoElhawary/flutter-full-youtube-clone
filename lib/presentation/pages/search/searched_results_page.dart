import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/presentation/common_widgets/arrow_back.dart';
import 'package:youtube/presentation/common_widgets/custom_circle_progress.dart';
import 'package:youtube/presentation/common_widgets/thumbnail_of_video.dart';
import 'package:youtube/presentation/cubit/search/search_cubit.dart';
import 'package:youtube/presentation/pages/search/widgets/searched_text_field.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import 'widgets/mic_button.dart';

class SearchedResultsPageParameter{
  final String text;

  SearchedResultsPageParameter({required this.text});
}
class SearchedResultsPage extends StatefulWidget {
  const SearchedResultsPage(this.parameter,{Key? key}) : super(key: key);
  final SearchedResultsPageParameter parameter;

  @override
  State<SearchedResultsPage> createState() => _SearchedResultsPageState();
}

class _SearchedResultsPageState extends State<SearchedResultsPage>
    with AutomaticKeepAliveClientMixin<SearchedResultsPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    TextEditingController controller = TextEditingController(text: widget.parameter.text);

    return Scaffold(
      appBar: AppBar(
        leading:  const ArrowBack(),
        surfaceTintColor: ColorManager(context).white,
        title: SearchTextField(controller: controller, enableOnTap: true),
        actions: [
          const RSizedBox(width: 15),
          const MicIconButton(),
          const RSizedBox(width: 20),
          SvgPicture.asset(IconsAssets.menuPointsVerticalIcon, height: 15),
          const RSizedBox(width: 20),
        ],
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        bloc: SearchCubit.get(context)..searchForThisSentence(widget.parameter.text),
        builder: (context, state) {
          return state.maybeWhen(
              searchForTheSentenceLoaded: (videosDetails) => ListView.builder(
                  itemBuilder: (context, index) => Padding(
                        padding: REdgeInsets.only(bottom: 15),
                        child: ThumbnailOfVideo(
                            videosDetails.videoDetailsItem?[index]),
                      ),
                  itemCount: videosDetails.videoDetailsItem?.length),
              searchLoading: () => const ThineCircularProgress(),
              searchError: (e) {
                return Center(
                  child: Text(
                      NetworkExceptions.getErrorMessage(e.networkExceptions)));
              },
              orElse: () =>
                  const Center(child: Text("There is something wrong")));
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
