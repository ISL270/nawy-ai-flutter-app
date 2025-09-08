import 'dart:io';

/// Test Runner Script - Automated test execution for API model validation
/// Run this script regularly to catch API changes early
void main() async {
  print('🧪 Running API Model Validation Tests...\n');
  
  final testSuites = [
    'test/features/search/data/sources/remote/api_contract_test.dart',
    'test/features/search/data/sources/remote/models/property_dto_test.dart',
    'test/features/search/data/sources/remote/models/search_response_test.dart',
    'test/features/search/data/sources/remote/property_remote_source_test.dart',
    'test/features/search/api_monitoring_test.dart',
  ];
  
  bool allTestsPassed = true;
  
  for (final testSuite in testSuites) {
    print('📋 Running: $testSuite');
    
    final result = await Process.run(
      'flutter',
      ['test', testSuite],
      workingDirectory: Directory.current.path,
    );
    
    if (result.exitCode == 0) {
      print('✅ PASSED\n');
    } else {
      print('❌ FAILED');
      print('STDOUT: ${result.stdout}');
      print('STDERR: ${result.stderr}\n');
      allTestsPassed = false;
    }
  }
  
  print('=' * 50);
  if (allTestsPassed) {
    print('🎉 All API model validation tests PASSED!');
    print('Your models are in sync with the API.');
  } else {
    print('⚠️  Some tests FAILED!');
    print('Please review the failures and update your models accordingly.');
    exit(1);
  }
}
