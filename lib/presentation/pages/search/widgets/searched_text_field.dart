import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/presentation/cubit/search/search_cubit.dart';

import '../../../../config/routes/route_app.dart';
import '../search_page.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField(
      {Key? key, required this.controller, this.enableOnTap = false})
      : super(key: key);
  final TextEditingController controller;
  final bool enableOnTap;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (input) {
        BlocProvider.of<SearchCubit>(context).getSuggestionTexts(input);
      },
      readOnly: enableOnTap,
      onTap: !enableOnTap
          ? null
          : () {
              Go(context)
                  .to(materialRoute: true, SearchPage(text: controller.text));
            },
      controller: controller,
      cursorColor: ColorManager(context).black,
      cursorWidth: 1.5.w,
      style: getNormalStyle(color: ColorManager(context).black, fontSize: 16),
      decoration: InputDecoration(
        hintText: "Search Youtube",
        hintStyle:
            getNormalStyle(color: ColorManager(context).grey8, fontSize: 16),
        fillColor: ColorManager(context).grey1,
        filled: true,
        isDense: true,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none),
        contentPadding: REdgeInsets.symmetric(horizontal: 10, vertical: 7),
      ),
    );
  }
}
