import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nawy_app/app/core/constants/api_constants.dart';
import 'package:nawy_app/app/core/utils/app_logger.dart';
import 'package:nawy_app/app/core/utils/dio_client.dart';

// Mock classes
class MockAppLogger extends Mock implements AppLogger {}

void main() {
  group('DioClient Tests', () {
    late DioClient dioClient;
    late MockAppLogger mockLogger;

    setUp(() {
      mockLogger = MockAppLogger();
      dioClient = DioClient(mockLogger);
    });

    test('should initialize Dio with correct base configuration', () {
      // Act
      dioClient.initialize();

      // Assert
      expect(dioClient.dio.options.baseUrl, equals(ApiConstants.baseUrl));
      expect(
        dioClient.dio.options.connectTimeout,
        equals(Duration(milliseconds: ApiConstants.connectTimeout)),
      );
      expect(
        dioClient.dio.options.receiveTimeout,
        equals(Duration(milliseconds: ApiConstants.receiveTimeout)),
      );
      expect(dioClient.dio.options.headers['Content-Type'], equals('application/json'));
      expect(dioClient.dio.options.headers['Accept'], equals('application/json'));
    });

    test('should add interceptors during initialization', () {
      // Act
      dioClient.initialize();

      // Assert
      expect(dioClient.dio.interceptors.length, greaterThan(0));
      expect(dioClient.dio.interceptors.any((i) => i is LogInterceptor), isTrue);
      expect(dioClient.dio.interceptors.any((i) => i is InterceptorsWrapper), isTrue);
    });

    test('should handle multiple initialization attempts', () {
      // Act & Assert - First initialization should work
      expect(() => dioClient.initialize(), returnsNormally);
      
      // Second initialization should throw because of late final field
      expect(() => dioClient.initialize(), throwsA(anything));
    });

    group('Configuration Validation', () {
      test('should have correct timeout values', () {
        // Act
        dioClient.initialize();

        // Assert
        expect(
          dioClient.dio.options.connectTimeout?.inMilliseconds,
          equals(ApiConstants.connectTimeout),
        );
        expect(
          dioClient.dio.options.receiveTimeout?.inMilliseconds,
          equals(ApiConstants.receiveTimeout),
        );
      });

      test('should have correct headers', () {
        // Act
        dioClient.initialize();

        // Assert
        final headers = dioClient.dio.options.headers;
        expect(headers['Content-Type'], equals('application/json'));
        expect(headers['Accept'], equals('application/json'));
      });
    });

    group('HTTP Methods Support', () {
      setUp(() {
        dioClient.initialize();
      });

      test('should provide access to Dio instance for HTTP methods', () {
        // Assert - Verify that dio instance is accessible and has expected methods
        expect(dioClient.dio, isA<Dio>());
        expect(dioClient.dio.options.baseUrl, isNotEmpty);
      });
    });

    group('Logging Integration', () {
      setUp(() {
        dioClient.initialize();
      });

      test('should configure LogInterceptor with correct settings', () {
        // Arrange
        final logInterceptor = dioClient.dio.interceptors
            .firstWhere((interceptor) => interceptor is LogInterceptor) as LogInterceptor;

        // Assert - LogInterceptor should be configured with custom logPrint
        expect(logInterceptor.logPrint, isNotNull);
        expect(logInterceptor.requestBody, isTrue);
        expect(logInterceptor.responseBody, isTrue);
      });

      test('should have error interceptor configured', () {
        // Arrange & Act
        final errorInterceptor = dioClient.dio.interceptors
            .firstWhere((interceptor) => interceptor is InterceptorsWrapper);

        // Assert - Error interceptor should exist
        expect(errorInterceptor, isNotNull);
        expect(errorInterceptor, isA<InterceptorsWrapper>());
      });
    });

    group('Integration with API Constants', () {
      test('should use correct configuration from ApiConstants', () {
        // Act
        dioClient.initialize();

        // Assert - Verify configuration matches ApiConstants
        expect(dioClient.dio.options.baseUrl, equals(ApiConstants.baseUrl));
        expect(
          dioClient.dio.options.connectTimeout?.inMilliseconds,
          equals(ApiConstants.connectTimeout),
        );
        expect(
          dioClient.dio.options.receiveTimeout?.inMilliseconds,
          equals(ApiConstants.receiveTimeout),
        );
      });
    });

    group('Singleton Behavior', () {
      test('should maintain singleton pattern through dependency injection', () {
        // Act
        dioClient.initialize();
        final dio1 = dioClient.dio;
        final dio2 = dioClient.dio;

        // Assert - Same instance should be returned
        expect(identical(dio1, dio2), isTrue);
      });
    });
  });
}
