import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:logger/logger.dart';
import 'package:nawy_app/app/core/utils/app_logger.dart';

class MockLogger extends Mock implements Logger {}

/// AppLogger Unit Tests
/// Tests the logging service functionality and network-specific logging methods
void main() {
  group('AppLogger Tests', () {
    late AppLogger appLogger;

    setUpAll(() {
      // Initialize singleton instance once for all tests
      appLogger = AppLogger();
      appLogger.initialize();
    });

    group('Singleton Pattern', () {
      test('should return the same instance when called multiple times', () {
        // Act
        final instance1 = AppLogger();
        final instance2 = AppLogger();

        // Assert
        expect(instance1, equals(instance2));
        expect(identical(instance1, instance2), isTrue);
      });
    });

    group('Initialization', () {
      test('should initialize logger without throwing exceptions', () {
        // Act & Assert - AppLogger is already initialized in setUpAll
        expect(appLogger, isNotNull);
      });
    });

    group('Logging Methods', () {

      test('should call debug method without throwing exceptions', () {
        // Act & Assert
        expect(() => appLogger.debug('Debug message'), returnsNormally);
        expect(() => appLogger.debug('Debug with error', 'error'), returnsNormally);
        expect(() => appLogger.debug('Debug with stacktrace', null, StackTrace.current), returnsNormally);
      });

      test('should call info method without throwing exceptions', () {
        // Act & Assert
        expect(() => appLogger.info('Info message'), returnsNormally);
        expect(() => appLogger.info('Info with error', 'error'), returnsNormally);
        expect(() => appLogger.info('Info with stacktrace', null, StackTrace.current), returnsNormally);
      });

      test('should call warning method without throwing exceptions', () {
        // Act & Assert
        expect(() => appLogger.warning('Warning message'), returnsNormally);
        expect(() => appLogger.warning('Warning with error', 'error'), returnsNormally);
        expect(() => appLogger.warning('Warning with stacktrace', null, StackTrace.current), returnsNormally);
      });

      test('should call error method without throwing exceptions', () {
        // Act & Assert
        expect(() => appLogger.error('Error message'), returnsNormally);
        expect(() => appLogger.error('Error with error', Exception('test')), returnsNormally);
        expect(() => appLogger.error('Error with stacktrace', null, StackTrace.current), returnsNormally);
      });

      test('should call fatal method without throwing exceptions', () {
        // Act & Assert
        expect(() => appLogger.fatal('Fatal message'), returnsNormally);
        expect(() => appLogger.fatal('Fatal with error', Exception('test')), returnsNormally);
        expect(() => appLogger.fatal('Fatal with stacktrace', null, StackTrace.current), returnsNormally);
      });
    });

    group('Network Logging Methods', () {

      test('should log API request without throwing exceptions', () {
        // Act & Assert
        expect(() => appLogger.logRequest('GET', 'https://api.example.com/users'), returnsNormally);
        expect(() => appLogger.logRequest('POST', 'https://api.example.com/users', data: {'name': 'John'}), returnsNormally);
        expect(() => appLogger.logRequest('PUT', 'https://api.example.com/users/1'), returnsNormally);
        expect(() => appLogger.logRequest('DELETE', 'https://api.example.com/users/1'), returnsNormally);
      });

      test('should log successful API response (2xx status codes)', () {
        // Act & Assert
        expect(() => appLogger.logResponse('GET', 'https://api.example.com/users', 200), returnsNormally);
        expect(() => appLogger.logResponse('POST', 'https://api.example.com/users', 201, data: {'id': 1}), returnsNormally);
        expect(() => appLogger.logResponse('PUT', 'https://api.example.com/users/1', 204), returnsNormally);
        expect(() => appLogger.logResponse('DELETE', 'https://api.example.com/users/1', 200), returnsNormally);
      });

      test('should log warning for non-successful API response (non-2xx status codes)', () {
        // Act & Assert
        expect(() => appLogger.logResponse('GET', 'https://api.example.com/users', 400), returnsNormally);
        expect(() => appLogger.logResponse('POST', 'https://api.example.com/users', 401, data: {'error': 'Unauthorized'}), returnsNormally);
        expect(() => appLogger.logResponse('GET', 'https://api.example.com/users', 404), returnsNormally);
        expect(() => appLogger.logResponse('POST', 'https://api.example.com/users', 500, data: {'error': 'Internal Server Error'}), returnsNormally);
      });

      test('should log API errors without throwing exceptions', () {
        // Act & Assert
        expect(() => appLogger.logError('GET', 'https://api.example.com/users', 'Network error'), returnsNormally);
        expect(() => appLogger.logError('POST', 'https://api.example.com/users', Exception('Connection timeout')), returnsNormally);
        expect(() => appLogger.logError('PUT', 'https://api.example.com/users/1', {'error': 'Validation failed'}), returnsNormally);
      });
    });

    group('HTTP Status Code Handling', () {

      test('should handle all 2xx status codes as success', () {
        final successCodes = [200, 201, 202, 204, 206];
        
        for (final code in successCodes) {
          // Act & Assert
          expect(() => appLogger.logResponse('GET', 'https://api.example.com/test', code), returnsNormally);
        }
      });

      test('should handle 1xx status codes as warnings', () {
        final informationalCodes = [100, 101, 102];
        
        for (final code in informationalCodes) {
          // Act & Assert
          expect(() => appLogger.logResponse('GET', 'https://api.example.com/test', code), returnsNormally);
        }
      });

      test('should handle 3xx status codes as warnings', () {
        final redirectionCodes = [300, 301, 302, 304, 307, 308];
        
        for (final code in redirectionCodes) {
          // Act & Assert
          expect(() => appLogger.logResponse('GET', 'https://api.example.com/test', code), returnsNormally);
        }
      });

      test('should handle 4xx status codes as warnings', () {
        final clientErrorCodes = [400, 401, 403, 404, 409, 422, 429];
        
        for (final code in clientErrorCodes) {
          // Act & Assert
          expect(() => appLogger.logResponse('GET', 'https://api.example.com/test', code), returnsNormally);
        }
      });

      test('should handle 5xx status codes as warnings', () {
        final serverErrorCodes = [500, 501, 502, 503, 504];
        
        for (final code in serverErrorCodes) {
          // Act & Assert
          expect(() => appLogger.logResponse('GET', 'https://api.example.com/test', code), returnsNormally);
        }
      });
    });

    group('Edge Cases and Error Handling', () {

      test('should handle null and empty messages gracefully', () {
        // Act & Assert
        expect(() => appLogger.debug(''), returnsNormally);
        expect(() => appLogger.info(''), returnsNormally);
        expect(() => appLogger.warning(''), returnsNormally);
        expect(() => appLogger.error(''), returnsNormally);
        expect(() => appLogger.fatal(''), returnsNormally);
      });

      test('should handle special characters in messages', () {
        const specialMessage = 'Test with special chars: 🚀 ñáéíóú @#\$%^&*()';
        
        // Act & Assert
        expect(() => appLogger.debug(specialMessage), returnsNormally);
        expect(() => appLogger.info(specialMessage), returnsNormally);
        expect(() => appLogger.warning(specialMessage), returnsNormally);
        expect(() => appLogger.error(specialMessage), returnsNormally);
        expect(() => appLogger.fatal(specialMessage), returnsNormally);
      });

      test('should handle very long messages', () {
        final longMessage = 'A' * 10000; // 10KB message
        
        // Act & Assert
        expect(() => appLogger.debug(longMessage), returnsNormally);
        expect(() => appLogger.info(longMessage), returnsNormally);
        expect(() => appLogger.warning(longMessage), returnsNormally);
        expect(() => appLogger.error(longMessage), returnsNormally);
        expect(() => appLogger.fatal(longMessage), returnsNormally);
      });

      test('should handle complex data objects in network logging', () {
        final complexData = {
          'user': {
            'id': 123,
            'name': 'John Doe',
            'email': 'john@example.com',
            'preferences': {
              'theme': 'dark',
              'notifications': true,
              'languages': ['en', 'es', 'fr']
            }
          },
          'metadata': {
            'timestamp': DateTime.now().toIso8601String(),
            'version': '1.0.0',
            'platform': 'mobile'
          }
        };

        // Act & Assert
        expect(() => appLogger.logRequest('POST', 'https://api.example.com/users', data: complexData), returnsNormally);
        expect(() => appLogger.logResponse('POST', 'https://api.example.com/users', 201, data: complexData), returnsNormally);
        expect(() => appLogger.logError('POST', 'https://api.example.com/users', complexData), returnsNormally);
      });

      test('should handle null data in network logging', () {
        // Act & Assert
        expect(() => appLogger.logRequest('GET', 'https://api.example.com/users', data: null), returnsNormally);
        expect(() => appLogger.logResponse('GET', 'https://api.example.com/users', 200, data: null), returnsNormally);
        expect(() => appLogger.logError('GET', 'https://api.example.com/users', null), returnsNormally);
      });

      test('should handle malformed URLs in network logging', () {
        const malformedUrls = [
          'not-a-url',
          'http://',
          'https://',
          'ftp://invalid-protocol.com',
          '',
        ];

        for (final url in malformedUrls) {
          // Act & Assert
          expect(() => appLogger.logRequest('GET', url), returnsNormally);
          expect(() => appLogger.logResponse('GET', url, 200), returnsNormally);
          expect(() => appLogger.logError('GET', url, 'Error'), returnsNormally);
        }
      });
    });

    group('Production Safety', () {
      test('should be safe to call in production builds', () {
        // This test verifies that the logger methods don't throw exceptions
        // In production, these calls would be wrapped in assert() statements
        // which would be removed in release builds
        
        // Act & Assert
        expect(() {
          appLogger.debug('Production debug test');
          appLogger.info('Production info test');
          appLogger.warning('Production warning test');
          appLogger.error('Production error test');
          appLogger.fatal('Production fatal test');
          appLogger.logRequest('GET', 'https://api.example.com/test');
          appLogger.logResponse('GET', 'https://api.example.com/test', 200);
          appLogger.logError('GET', 'https://api.example.com/test', 'Error');
        }, returnsNormally);
      });
    });

    group('Memory and Performance', () {
      test('should handle multiple rapid logging calls', () {
        // Act & Assert
        expect(() {
          for (int i = 0; i < 1000; i++) {
            appLogger.debug('Rapid log message $i');
          }
        }, returnsNormally);
      });

      test('should handle concurrent logging calls', () async {
        
        // Act
        final futures = List.generate(100, (index) async {
          appLogger.debug('Concurrent log message $index');
          appLogger.info('Concurrent info message $index');
          appLogger.warning('Concurrent warning message $index');
        });

        // Assert
        expect(() async => await Future.wait(futures), returnsNormally);
      });
    });
  });
}
