import 'package:get/get.dart';

class MiniPlayerLogic extends GetxController {
  final Rx<double> _heightNotifier = Rx<double>(0);
  final Rx<double> _heightPercentage = Rx<double>(0);
  final Rx<double> _maxHeight = Rx<double>(0);
  final Rx<double> _minHeight = Rx<double>(0);

  double get heightNotifier => _heightNotifier.value;

  set heightNotifier(double height) {
    _heightNotifier.value = height;
    double percentage = (height - minHeight) / (maxHeight - minHeight);
    _heightPercentage.value = percentage;
  }

  double get maxHeight => _maxHeight.value;

  set maxHeight(double value) {
    _maxHeight.value = value;
  }

  double get heightPercentage => _heightPercentage.value;

  set heightPercentage(double value) => _heightPercentage.value = value;

  double get minHeight => _minHeight.value;

  set minHeight(double value) => _minHeight.value = value;
}
