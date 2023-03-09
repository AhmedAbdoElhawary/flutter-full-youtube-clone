import 'package:flutter/material.dart';
import 'package:youtube/core/functions/handling_errors/network_exception_model.dart';
import 'package:youtube/core/functions/handling_errors/network_exceptions.dart';
import 'package:youtube/core/functions/toast_show.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget(this.exception, {Key? key}) : super(key: key);
  final NetworkExceptionModel exception;
  @override
  Widget build(BuildContext context) {
    ToastShow.reformatToast(context, exception.error);
    return Center(
      child: Text(
          NetworkExceptions.getErrorMessage(exception.networkExceptions),
          style:
              getNormalStyle(color: ColorManager(context).black, fontSize: 15)),
    );
  }
}
