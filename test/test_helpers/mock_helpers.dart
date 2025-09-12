import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nawy_app/app/core/utils/app_logger.dart';
import 'package:nawy_app/app/core/utils/dio_client.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/property_search_remote_source.dart';

/// Mock classes for testing
class MockDio extends Mock implements Dio {}

class MockDioClient extends Mock implements DioClient {}

class MockAppLogger extends Mock implements AppLogger {}

class MockPropertyRemoteSource extends Mock implements PropertySearchRemoteSource {}

/// Test helper utilities for creating mock objects and test data
class MockHelpers {
  /// Creates a mock Dio instance with common stubbed methods
  static MockDio createMockDio() {
    final mockDio = MockDio();

    // Register fallback values for common types
    registerFallbackValue(RequestOptions(path: ''));
    registerFallbackValue(Response(requestOptions: RequestOptions(path: ''), statusCode: 200));

    return mockDio;
  }

  /// Creates a mock DioClient with common stubbed methods
  static MockDioClient createMockDioClient() {
    final mockDioClient = MockDioClient();

    // Register fallback values
    registerFallbackValue(RequestOptions(path: ''));

    return mockDioClient;
  }

  /// Creates a mock AppLogger with stubbed methods
  static MockAppLogger createMockAppLogger() {
    final mockAppLogger = MockAppLogger();

    // Stub all logging methods to do nothing by default (void methods don't need thenReturn)
    when(() => mockAppLogger.initialize()).thenReturn;
    when(() => mockAppLogger.debug(any(), any(), any())).thenReturn;
    when(() => mockAppLogger.info(any(), any(), any())).thenReturn;
    when(() => mockAppLogger.warning(any(), any(), any())).thenReturn;
    when(() => mockAppLogger.error(any(), any(), any())).thenReturn;
    when(() => mockAppLogger.fatal(any(), any(), any())).thenReturn;
    when(() => mockAppLogger.logRequest(any(), any(), data: any(named: 'data'))).thenReturn;
    when(() => mockAppLogger.logResponse(any(), any(), any(), data: any(named: 'data'))).thenReturn;
    when(() => mockAppLogger.logError(any(), any(), any())).thenReturn;

    return mockAppLogger;
  }

  /// Creates a mock PropertyRemoteSource with common stubbed methods
  static MockPropertyRemoteSource createMockPropertyRemoteSource() {
    final mockRemoteSource = MockPropertyRemoteSource();

    return mockRemoteSource;
  }

  /// Creates a successful Dio Response for testing
  static Response<T> createSuccessResponse<T>(T data, {int statusCode = 200}) {
    return Response<T>(
      data: data,
      statusCode: statusCode,
      requestOptions: RequestOptions(path: '/test'),
    );
  }

  /// Creates a Dio error response for testing
  static DioException createDioError({
    int statusCode = 500,
    String message = 'Server Error',
    DioExceptionType type = DioExceptionType.badResponse,
  }) {
    return DioException(
      requestOptions: RequestOptions(path: '/test'),
      response: Response(
        statusCode: statusCode,
        statusMessage: message,
        requestOptions: RequestOptions(path: '/test'),
      ),
      type: type,
      message: message,
    );
  }

  /// Creates a network timeout error for testing
  static DioException createTimeoutError() {
    return DioException(
      requestOptions: RequestOptions(path: '/test'),
      type: DioExceptionType.connectionTimeout,
      message: 'Connection timeout',
    );
  }

  /// Creates a network connection error for testing
  static DioException createConnectionError() {
    return DioException(
      requestOptions: RequestOptions(path: '/test'),
      type: DioExceptionType.connectionError,
      message: 'Connection failed',
    );
  }

  /// Verifies that a method was called with specific parameters
  static void verifyMethodCall(
    Mock mock,
    String methodName,
    List<dynamic> positionalArgs, [
    Map<Symbol, dynamic>? namedArgs,
  ]) {
    verify(
      () => mock.noSuchMethod(Invocation.method(Symbol(methodName), positionalArgs, namedArgs)),
    ).called(1);
  }

  /// Verifies that a method was never called
  static void verifyNeverCalled(
    Mock mock,
    String methodName,
    List<dynamic> positionalArgs, [
    Map<Symbol, dynamic>? namedArgs,
  ]) {
    verifyNever(
      () => mock.noSuchMethod(Invocation.method(Symbol(methodName), positionalArgs, namedArgs)),
    );
  }

  /// Sets up common fallback values for mocktail
  static void setupFallbackValues() {
    // Register fallback values for common types used in tests
    registerFallbackValue(RequestOptions(path: ''));
    registerFallbackValue(Response(requestOptions: RequestOptions(path: ''), statusCode: 200));
    registerFallbackValue(
      DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.unknown,
      ),
    );
  }

  /// Creates a mock response with proper typing
  static Response<Map<String, dynamic>> createMockJsonResponse(
    Map<String, dynamic> data, {
    int statusCode = 200,
  }) {
    return Response<Map<String, dynamic>>(
      data: data,
      statusCode: statusCode,
      requestOptions: RequestOptions(path: '/test'),
    );
  }

  /// Creates a mock response with list data
  static Response<List<Map<String, dynamic>>> createMockListResponse(
    List<Map<String, dynamic>> data, {
    int statusCode = 200,
  }) {
    return Response<List<Map<String, dynamic>>>(
      data: data,
      statusCode: statusCode,
      requestOptions: RequestOptions(path: '/test'),
    );
  }
}
