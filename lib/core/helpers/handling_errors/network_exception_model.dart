import 'package:youtube/core/helpers/handling_errors/network_exceptions.dart';

class NetworkExceptionModel {
  String error;
  NetworkExceptions networkExceptions;

  NetworkExceptionModel(this.error, this.networkExceptions);
}
