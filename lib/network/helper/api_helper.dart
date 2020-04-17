import 'dart:io';

import 'package:dio/dio.dart';

import '../app_exception.dart';

/// Base class for all the data source which will call
/// external APIs for the data.
class ApiHelper<T> {
  /// Wrapper for API calls for handling errors at common place
  /// instead of parsing it in calling Widgets.
  Future<T> callApi({
    Future<Response> future,
    Function(dynamic) successResponseParser,
  }) async {
    return future.then((response) {
      if (successResponseParser != null) {
        return Future.value(successResponseParser(response.data));
      } else {
        return Future.value(response.data);
      }
    }).catchError((error) {
      throw handleError(error);
    });
  }

  dynamic handleError(dynamic error) {
    // If error is DioError i.e http exception, we
    // should parse the exact message instead of
    // returning the HTTP Status code and standard message.
    if (error is DioError) {
      // Check if error is of time out error
      if (error.type == DioErrorType.SEND_TIMEOUT ||
          error.type == DioErrorType.CONNECT_TIMEOUT ||
          error.type == DioErrorType.RECEIVE_TIMEOUT) {
        return throw FetchDataException('No Internet connection');
      }

      // Check if the error is regarding no internet connection.
      if (error.type == DioErrorType.DEFAULT &&
          error.error is SocketException) {
        return throw FetchDataException('No Internet connection');
      }

      // Check if server responded with non-success status code.
      // In this case, we will check if we got a specific error
      // from API to display to the user.
      if (error.type == DioErrorType.RESPONSE) {
        final appException = _getErrorObject(error.response);
        if (appException != null) {
          return appException;
        }
      }
    }

    // We are here that means the error wasn't http exception.
    // This could be any un-handled exception from server.
    // In this case, instead of showing weird errors to users
    // like bad response or internal server error, show him
    // a generic message.
    return AppException(
        'We are experiencing technical issues, Please try again!');
  }

  /// Parses the response to get the error object if any
  /// from the API response based on status code.
  AppException _getErrorObject(Response response) {
    // 502 => Bad Gateway server error response code
    if (response.statusCode == 502) {
      return AppException(
          'We are experiencing technical issues, Please try again!');
    }

    return AppException(
        'Unhandled Exception: Status Code [${response.statusCode}]');
  }
}
