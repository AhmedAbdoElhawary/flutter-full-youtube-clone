import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/core/functions/handling_errors/error_model.dart';
import 'package:youtube/core/functions/handling_errors/network_exception_model.dart';

part 'network_exceptions.freezed.dart';

@freezed
class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorizedRequest(String reason) =
      UnauthorizedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.unProcessableEntity(String reason) =
      UnprocessableEntity;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.errorConnection() = ErrorConnection;

  const factory NetworkExceptions.badCertificate() = BadCertificate;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions handleResponse(Response? response) {
    List<ErrorModel> listOfErrors =
        List.from(response?.data).map((e) => ErrorModel.fromJson(e)).toList();
    String allErrors = listOfErrors
        .map((e) => "${e.field} : ${e.message}  ")
        .toString()
        .replaceAll("(", "")
        .replaceAll(")", "");
    int statusCode = response?.statusCode ?? 0;
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return NetworkExceptions.unauthorizedRequest(allErrors);
      case 404:
        return NetworkExceptions.notFound(allErrors);
      case 409:
        return const NetworkExceptions.conflict();
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 422:
        return NetworkExceptions.unProcessableEntity(allErrors);
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      default:
        var responseCode = statusCode;
        return NetworkExceptions.defaultError(
          "Received invalid status code: $responseCode",
        );
    }
  }

  static NetworkExceptionModel getDioException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioErrorType.connectionTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioErrorType.unknown:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
            case DioErrorType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.badResponse:
              networkExceptions =
                  NetworkExceptions.handleResponse(error.response);
              break;
            case DioErrorType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.badCertificate:
              networkExceptions = const NetworkExceptions.badCertificate();
              break;
            case DioErrorType.connectionError:
              networkExceptions = const NetworkExceptions.errorConnection();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        NetworkExceptionModel networkExceptionModel =
            NetworkExceptionModel(error.toString(), networkExceptions);

        return networkExceptionModel;
      } on FormatException {
        return NetworkExceptionModel(
            error.toString(), const NetworkExceptions.formatException());
      } catch (_) {
        return NetworkExceptionModel(
            error.toString(), const NetworkExceptions.unexpectedError());
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return NetworkExceptionModel(
            error.toString(), const NetworkExceptions.unableToProcess());
      } else {
        return NetworkExceptionModel(
            error.toString(), const NetworkExceptions.unexpectedError());
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = "";
    networkExceptions.when(
      notImplemented: () => errorMessage = "Not Implemented",
      requestCancelled: () => errorMessage = "Request Cancelled",
      internalServerError: () => errorMessage = "Internal Server Error",
      notFound: (String reason) => errorMessage = reason,
      serviceUnavailable: () => errorMessage = "Service unavailable",
      methodNotAllowed: () => errorMessage = "Method Allowed",
      badRequest: () => errorMessage = "Bad request",
      unauthorizedRequest: (String error) => errorMessage = error,
      unProcessableEntity: (String error) => errorMessage = error,
      unexpectedError: () => errorMessage = "Unexpected error occurred",
      requestTimeout: () => errorMessage = "Connection request timeout",
      noInternetConnection: () => errorMessage = "No internet connection",
      conflict: () => errorMessage = "Error due to a conflict",
      sendTimeout: () =>
          errorMessage = "Send timeout in connection with API server",
      unableToProcess: () => errorMessage = "Unable to process the data",
      defaultError: (String error) => errorMessage = error,
      formatException: () => errorMessage = "Unexpected error occurred",
      notAcceptable: () => errorMessage = "Not acceptable",
      badCertificate: () => errorMessage = "Bad certificate",
      errorConnection: ()=>errorMessage = "Error connection",
    );
    return errorMessage;
  }
}
