import 'package:logger/logger.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;
  AppLogger._internal();

  late final Logger _logger;

  void initialize() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0, // No method calls stack trace for cleaner output
        errorMethodCount: 3, // Reduced method calls for errors only
        lineLength: 80, // Shorter lines for better readability
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        dateTimeFormat: DateTimeFormat.none, // No timestamp in logs
      ),
      level: Level.debug, // Changed to debug level to show all logs including errors
    );
  }

  // Debug level - for detailed diagnostic information
  void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  // Info level - for general information
  void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  // Warning level - for potentially harmful situations
  void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  // Error level - for error events
  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  // Fatal level - for very severe error events
  void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  // Network specific logging methods
  void logRequest(String method, String url, {Map<String, dynamic>? data}) {
    debug('🌐 API Request: $method $url', data);
  }

  void logResponse(String method, String url, int statusCode, {dynamic data}) {
    if (statusCode >= 200 && statusCode < 300) {
      debug('✅ API Response: $method $url [$statusCode]', data);
    } else {
      warning('⚠️ API Response: $method $url [$statusCode]', data);
    }
  }

  void logError(String method, String url, dynamic error) {
    this.error('❌ API Error: $method $url', error);
  }
}
