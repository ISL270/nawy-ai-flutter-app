import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:nawy_app/app/core/utils/hive_service.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/models/property_hive.dart';

void main() {
  group('HiveService', () {
    late HiveService hiveService;

    setUpAll(() async {
      // Initialize Hive for testing
      Hive.init('./test/hive_test_db');
    });

    setUp(() {
      hiveService = HiveService();
    });

    tearDown(() async {
      // Close all boxes after each test
      try {
        await Hive.close();
      } catch (e) {
        // Ignore close errors in tests
      }
    });

    tearDownAll(() async {
      // Clean up test database
      try {
        await Hive.deleteFromDisk();
      } catch (e) {
        // Ignore cleanup errors
      }
    });

    group('Initialization', () {
      test('should initialize successfully', () async {
        await hiveService.initialize();
        
        expect(hiveService.propertyBox.isOpen, true);
        expect(hiveService.compoundBox.isOpen, true);
        expect(hiveService.areaBox.isOpen, true);
        expect(hiveService.developerBox.isOpen, true);
        expect(hiveService.propertyTypeBox.isOpen, true);
      });

      test('should handle multiple initialization calls gracefully', () async {
        await hiveService.initialize();
        await hiveService.initialize(); // Should not throw
        
        expect(hiveService.propertyBox.isOpen, true);
      });
    });

    group('Basic Operations', () {
      setUp(() async {
        await hiveService.initialize();
      });

      test('should provide access to all boxes', () {
        expect(hiveService.propertyBox, isNotNull);
        expect(hiveService.compoundBox, isNotNull);
        expect(hiveService.areaBox, isNotNull);
        expect(hiveService.developerBox, isNotNull);
        expect(hiveService.propertyTypeBox, isNotNull);
      });

      test('should allow storing and retrieving PropertyHive objects', () async {
        final property = PropertyHive()
          ..propertyId = 1
          ..name = 'Test Property'
          ..isFavorite = true;

        await hiveService.propertyBox.put('property_1', property);
        final retrieved = hiveService.propertyBox.get('property_1');

        expect(retrieved, isNotNull);
        expect(retrieved!.propertyId, 1);
        expect(retrieved.name, 'Test Property');
        expect(retrieved.isFavorite, true);
      });

      test('should handle empty boxes gracefully', () async {
        expect(hiveService.propertyBox.isEmpty, true);
        expect(hiveService.compoundBox.isEmpty, true);
        expect(hiveService.areaBox.isEmpty, true);
        expect(hiveService.developerBox.isEmpty, true);
        expect(hiveService.propertyTypeBox.isEmpty, true);
      });
    });

    group('Cleanup', () {
      setUp(() async {
        await hiveService.initialize();
      });

      test('should close all boxes successfully', () async {
        expect(hiveService.propertyBox.isOpen, true);
        
        await hiveService.close();
        
        expect(hiveService.propertyBox.isOpen, false);
        expect(hiveService.compoundBox.isOpen, false);
        expect(hiveService.areaBox.isOpen, false);
        expect(hiveService.developerBox.isOpen, false);
        expect(hiveService.propertyTypeBox.isOpen, false);
      });
    });
  });
}
