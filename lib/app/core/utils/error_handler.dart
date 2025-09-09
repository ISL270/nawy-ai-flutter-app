import 'dart:io';
import 'dart:async';

import 'package:nawy_app/app/core/injection/injection.dart';
import 'package:nawy_app/app/core/utils/app_logger.dart';

/// Custom exception that preserves original exception type and provides user-friendly message
class AppException implements Exception {
  final String message;
  final Exception originalException;

  const AppException(this.message, this.originalException);

  @override
  String toString() => message;
}

/// Centralized error handling utility for consistent error processing across the app
class ErrorHandler {
  static AppLogger? get _logger {
    try {
      return getIt<AppLogger>();
    } catch (e) {
      // Logger not registered (likely in test environment)
      return null;
    }
  }

  const ErrorHandler._();

  /// Handles exceptions and returns user-friendly error messages
  /// Also logs the error with appropriate level and context
  static String handleError(dynamic error, StackTrace? stackTrace, String context) {
    final errorMessage = _mapErrorToUserMessage(error);
    
    // Log error with context
    assert(() {
      if (error is SocketException) {
        _logger?.warning('$context - Network error: ${error.message}');
      } else if (error is TimeoutException) {
        _logger?.error('$context - Timeout: ${error.message}');
      } else if (error is FormatException) {
        _logger?.error('$context - Format error: ${error.message}');
      } else {
        _logger?.fatal('$context - Unexpected error: $error');
      }
      
      if (stackTrace != null) {
        _logger?.debug('Stack trace: $stackTrace');
      }
      
      return true;
    }());

    return errorMessage;
  }

  /// Maps technical exceptions to user-friendly messages
  static String _mapErrorToUserMessage(dynamic error) {
    if (error is SocketException) {
      return 'No internet connection. Please check your network and try again.';
    }

    if (error is TimeoutException) {
      return 'Request timed out. Please try again.';
    }

    if (error is FormatException) {
      return 'Invalid data received from server. Please try again.';
    }

    // Handle string-based error checking for compatibility
    final errorString = error.toString().toLowerCase();
    
    if (errorString.contains('socketexception') || 
        errorString.contains('networkexception')) {
      return 'No internet connection. Please check your network and try again.';
    }

    if (errorString.contains('timeoutexception')) {
      return 'Request timed out. Please try again.';
    }

    if (errorString.contains('formatexception')) {
      return 'Invalid data received from server. Please try again.';
    }

    // Generic error message for unknown errors
    return 'Something went wrong. Please try again.';
  }

  /// Wraps async operations with timeout and error handling
  static Future<T> executeWithTimeout<T>(
    Future<T> Function() operation,
    Duration timeout,
    String operationName,
  ) async {
    assert(() {
      _logger?.debug('$operationName - Starting operation');
      return true;
    }());

    try {
      final result = await operation().timeout(
        timeout,
        onTimeout: () {
          assert(() {
            _logger?.error('$operationName - Timeout after ${timeout.inSeconds} seconds');
            return true;
          }());
          throw TimeoutException('$operationName timed out', timeout);
        },
      );

      assert(() {
        _logger?.debug('$operationName - Completed successfully');
        return true;
      }());

      return result;
    } catch (error, stackTrace) {
      // Re-throw with context for upper layers to handle
      throw _wrapErrorWithContext(error, operationName, stackTrace);
    }
  }

  /// Wraps errors with additional context while preserving original type
  static Exception _wrapErrorWithContext(dynamic error, String context, StackTrace stackTrace) {
    final userMessage = _mapErrorToUserMessage(error);
    
    if (error is Exception) {
      return AppException(userMessage, error);
    }
    return AppException(userMessage, Exception('$context: ${error.toString()}'));
  }
}
