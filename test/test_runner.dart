import 'dart:io';
import 'package:flutter/foundation.dart';

/// Test Runner Script - Automated test execution for API model validation
/// Run this script regularly to catch API changes early
void main() async {
  debugPrint('🧪 Running API Model Validation Tests...\n');
  
  final testSuites = [
    'test/features/search/data/sources/remote/api_contract_test.dart',
    'test/features/search/data/sources/remote/models/property_dto_test.dart',
    'test/features/search/data/sources/remote/models/search_response_test.dart',
    'test/features/search/data/sources/remote/property_remote_source_test.dart',
    'test/features/search/api_monitoring_test.dart',
  ];
  
  bool allTestsPassed = true;
  
  for (final testSuite in testSuites) {
    debugPrint('📋 Running: $testSuite');
    
    final result = await Process.run(
      'flutter',
      ['test', testSuite],
      workingDirectory: Directory.current.path,
    );
    
    if (result.exitCode == 0) {
      debugPrint('✅ PASSED\n');
    } else {
      debugPrint('❌ FAILED');
      debugPrint('STDOUT: ${result.stdout}');
      debugPrint('STDERR: ${result.stderr}\n');
      allTestsPassed = false;
    }
  }
  
  debugPrint('=' * 50);
  if (allTestsPassed) {
    debugPrint('🎉 All API model validation tests PASSED!');
    debugPrint('Your models are in sync with the API.');
  } else {
    debugPrint('⚠️  Some tests FAILED!');
    debugPrint('Please review the failures and update your models accordingly.');
    exit(1);
  }
}
