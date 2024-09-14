import '../error/exceptions.dart';

class ErrorHandler {
  static bool handleRemoteError(int statusCode) {
    if (statusCode >= 200 && statusCode < 300) {
      return true;
    } else if (statusCode == 401) {
      throw ServerException(ErrorCodes.unAuth);
    } else if (statusCode == 422) {
      throw ServerException(ErrorCodes.wrongInput);
    } else if (statusCode == 403) {
      throw ServerException(ErrorCodes.forbidden);
    }
    return false;
  }
}
