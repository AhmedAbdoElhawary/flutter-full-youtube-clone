import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/presentation/common_widgets/arrow_back.dart';
import 'package:youtube/presentation/cubit/search/search_cubit.dart';

import '../../../core/resources/color_manager.dart';
import '../../../core/resources/styles_manager.dart';
import 'searched_results_page.dart';
import 'widgets/mic_button.dart';
import 'widgets/searched_text_field.dart';

class SearchPage extends StatelessWidget {
  const SearchPage( {this.text = "",Key? key}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: text);
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBack(),
        surfaceTintColor: ColorManager(context).white,
        title: SearchTextField(controller: controller),
        actions: const [
          RSizedBox(width: 5),
          MicIconButton(),
          RSizedBox(width: 10),
        ],
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return state.maybeWhen(suggestionTextsLoaded: (suggestionTexts) {
            return ListView.builder(
                itemBuilder: (context, index) =>
                    _ItemBuilderWidget(suggestionTexts.suggestions[index]),
                itemCount: suggestionTexts.suggestions.length);
          }, searchError: (error) {
            return const SizedBox();
          }, orElse: () {
            return const SizedBox();
          });
        },
      ),
    );
  }
}

class _ItemBuilderWidget extends StatelessWidget {
  const _ItemBuilderWidget(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Go(context).offCurrent(
            SearchedResultsPage(SearchedResultsPageParameter(text: text)));
      },

      /// To be nice alignment when tapping on it
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 15),
        child: Padding(
          padding: REdgeInsets.only(top: 7.5, bottom: 7.5),
          child: Row(
            children: [
              const Icon(Icons.watch_later_outlined),
              const RSizedBox(width: 22),
              Expanded(
                child: Text(
                  text,
                  style: getMediumStyle(
                      color: ColorManager(context).black, fontSize: 15),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                  width: 45.r,
                  height: 40.r,
                  color: ColorManager(context).grey2),
              const RSizedBox(width: 15),
              Transform.rotate(
                angle: 0.785398,
                child: const Icon(Icons.arrow_back_rounded, size: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
