import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../constants/api_constants.dart';
import 'app_logger.dart';

@singleton
class DioClient {
  final AppLogger _logger;
  
  DioClient(this._logger);

  late final Dio _dio;

  Dio get dio => _dio;

  void initialize() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
      receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors for logging and error handling
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object) {
        // Only log in debug mode
        assert(() {
          _logger.debug(object.toString());
          return true;
        }());
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler) {
        // Handle common errors
        _handleError(error);
        handler.next(error);
      },
    ));
  }

  void _handleError(DioException error) {
    String errorMessage = 'Unknown error occurred';
    
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timeout';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Send timeout';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receive timeout';
        break;
      case DioExceptionType.badResponse:
        errorMessage = 'Server error: ${error.response?.statusCode}';
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request cancelled';
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'Connection error';
        break;
      case DioExceptionType.unknown:
        errorMessage = 'Network error';
        break;
      default:
        errorMessage = 'Unknown error';
    }
    
    // Log error for debugging
    assert(() {
      _logger.error('API Error: $errorMessage', error);
      return true;
    }());
  }
}
