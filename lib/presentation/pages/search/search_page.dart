import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/config/routes/route_app.dart';

import '../../../core/resources/color_manager.dart';
import '../../../core/resources/styles_manager.dart';
import 'searched_results_page.dart';
import 'widgets/mic_button.dart';
import 'widgets/searched_text_field.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({this.text = "", Key? key}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: text);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 5.w,
        surfaceTintColor: ColorManager(context).white,
        title: SearchTextField(controller: controller),
        actions: const [
          RSizedBox(width: 5),
          MicIconButton(),
          RSizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
          itemBuilder: (context, index) => const _ItemBuilderWidget(),
          itemCount: 50),
    );
  }
}

class _ItemBuilderWidget extends StatelessWidget {
  const _ItemBuilderWidget();

  @override
  Widget build(BuildContext context) {
    String text = "Solid Principles " * 2;
    return InkWell(
      onTap: () {
        Go(context).offCurrent(materialRoute: true,SearchedResultsPage(text: text));
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
              const Icon(Icons.arrow_back_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
