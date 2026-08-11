abstract class AppException implements Exception {
  final String message;

  const AppException(this.message);
}

class ServerException extends AppException {
  ServerException(super.message);
}

class NetworkException extends AppException {
  NetworkException(super.message);
}

class AuthException extends AppException {
  AuthException(super.message);
}

class CacheException extends AppException {
  CacheException(super.message);
}

class UnknownException extends AppException {
  UnknownException(super.message);
}
