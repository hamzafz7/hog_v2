
class ServerException implements Exception {
  final ErrorCodes errorCode;

  ServerException(this.errorCode);
}

class CacheException implements Exception {}


enum ErrorCodes {
  unAuth,
  wrongInput,
  forbidden,
  noConnection,
  tokenExpired,
  serverError,
  unKnownError,
  notSameDevice,
  passwordNotMatch,
  otpInvalid,
  emailWrong,
  SERVER_ERROR,
  UNKNOWN_ERROR
}
