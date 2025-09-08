import 'package:flutter_test/flutter_test.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/filter_options.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/property_type_dto.dart';

/// FilterOptions Unit Tests
/// Tests JSON serialization, deserialization for filter options and related models
void main() {
  group('FilterOptions Tests', () {
    const sampleFilterOptionsJson = {
      'min_bedrooms': 1,
      'max_bedrooms': 5,
      'min_price_list': [500000, 1000000, 2000000, 5000000],
      'max_price_list': [1000000, 2000000, 5000000, 10000000],
      'property_types': [
        {
          'id': 1,
          'name': 'Apartment',
          'icon': {
            'url': '/images/apartment.jpg'
          },
          'has_land_area': false,
          'has_mandatory_garden_area': false,
          'manual_ranking': 1
        },
        {
          'id': 2,
          'name': 'Villa',
          'icon': {
            'url': '/images/villa.jpg'
          },
          'has_land_area': true,
          'has_mandatory_garden_area': true,
          'manual_ranking': 2
        }
      ],
      'amenities': [
        {
          'id': 101,
          'name': 'Swimming Pool',
          'image_path': '/images/pool.jpg'
        },
        {
          'id': 102,
          'name': 'Gym',
          'image_path': null
        }
      ],
      'sortings': [
        {
          'key': 'price',
          'value': 'Price',
          'direction': 'asc'
        },
        {
          'key': 'date',
          'value': 'Date Added',
          'direction': 'desc'
        }
      ],
      'sale_types': ['sale', 'rent', 'resale']
    };

    const minimalFilterOptionsJson = {
      'min_bedrooms': 1,
      'max_bedrooms': 5,
      'min_price_list': [500000],
      'max_price_list': [10000000],
    };

    group('JSON Deserialization', () {
      test('should deserialize complete filter options from JSON', () {
        // Act
        final filterOptions = FilterOptions.fromJson(sampleFilterOptionsJson);

        // Assert
        expect(filterOptions.minBedrooms, equals(1));
        expect(filterOptions.maxBedrooms, equals(5));
        expect(filterOptions.minPriceList, equals([500000, 1000000, 2000000, 5000000]));
        expect(filterOptions.maxPriceList, equals([1000000, 2000000, 5000000, 10000000]));
        expect(filterOptions.propertyTypes, isNotNull);
        expect(filterOptions.propertyTypes!.length, equals(2));
        expect(filterOptions.propertyTypes![0].name, equals('Apartment'));
        expect(filterOptions.amenities, isNotNull);
        expect(filterOptions.amenities!.length, equals(2));
        expect(filterOptions.amenities![0].name, equals('Swimming Pool'));
        expect(filterOptions.sortings, isNotNull);
        expect(filterOptions.sortings!.length, equals(2));
        expect(filterOptions.sortings![0].key, equals('price'));
        expect(filterOptions.saleTypes, isNotNull);
        expect(filterOptions.saleTypes!.length, equals(3));
        expect(filterOptions.saleTypes![0], equals('sale'));
      });

      test('should deserialize minimal filter options with required fields only', () {
        // Act
        final filterOptions = FilterOptions.fromJson(minimalFilterOptionsJson);

        // Assert
        expect(filterOptions.minBedrooms, equals(1));
        expect(filterOptions.maxBedrooms, equals(5));
        expect(filterOptions.minPriceList, equals([500000]));
        expect(filterOptions.maxPriceList, equals([10000000]));
        expect(filterOptions.propertyTypes, isNull);
        expect(filterOptions.amenities, isNull);
        expect(filterOptions.sortings, isNull);
        expect(filterOptions.saleTypes, isNull);
      });

      test('should handle empty arrays', () {
        // Arrange
        final jsonWithEmptyArrays = {
          'min_bedrooms': 1,
          'max_bedrooms': 5,
          'min_price_list': <int>[],
          'max_price_list': <int>[],
          'property_types': <Map<String, dynamic>>[],
          'amenities': <Map<String, dynamic>>[],
          'sortings': <Map<String, dynamic>>[],
          'sale_types': <String>[],
        };

        // Act
        final filterOptions = FilterOptions.fromJson(jsonWithEmptyArrays);

        // Assert
        expect(filterOptions.minPriceList, isEmpty);
        expect(filterOptions.maxPriceList, isEmpty);
        expect(filterOptions.propertyTypes, isEmpty);
        expect(filterOptions.amenities, isEmpty);
        expect(filterOptions.sortings, isEmpty);
        expect(filterOptions.saleTypes, isEmpty);
      });
    });

    group('JSON Serialization', () {
      test('should serialize complete filter options to JSON', () {
        // Arrange
        final propertyTypes = [
          PropertyTypeDto(
            id: 1, 
            name: 'Apartment', 
            icon: PropertyTypeIconDto(url: '/images/apartment.jpg'),
            hasLandArea: false,
            hasMandatoryGardenArea: false,
            manualRanking: 1,
          ),
          PropertyTypeDto(
            id: 2, 
            name: 'Villa', 
            icon: PropertyTypeIconDto(url: '/images/villa.jpg'),
            hasLandArea: true,
            hasMandatoryGardenArea: true,
            manualRanking: 2,
          ),
        ];

        final amenities = [
          Amenity(id: 101, name: 'Swimming Pool', imagePath: '/images/pool.jpg'),
          Amenity(id: 102, name: 'Gym'),
        ];

        final sortings = [
          SortOption(key: 'price', value: 'Price', direction: 'asc'),
          SortOption(key: 'date', value: 'Date Added', direction: 'desc'),
        ];

        final filterOptions = FilterOptions(
          minBedrooms: 1,
          maxBedrooms: 5,
          minPriceList: [500000, 1000000, 2000000, 5000000],
          maxPriceList: [1000000, 2000000, 5000000, 10000000],
          propertyTypes: propertyTypes,
          amenities: amenities,
          sortings: sortings,
          saleTypes: ['sale', 'rent', 'resale'],
        );

        // Act
        final json = filterOptions.toJson();

        // Assert
        expect(json['min_bedrooms'], equals(1));
        expect(json['max_bedrooms'], equals(5));
        expect(json['min_price_list'], equals([500000, 1000000, 2000000, 5000000]));
        expect(json['max_price_list'], equals([1000000, 2000000, 5000000, 10000000]));
        expect(json['property_types'], isNotNull);
        expect(json['property_types'].length, equals(2));
        expect(json['amenities'], isNotNull);
        expect(json['amenities'].length, equals(2));
        expect(json['sortings'], isNotNull);
        expect(json['sortings'].length, equals(2));
        expect(json['sale_types'], equals(['sale', 'rent', 'resale']));
      });

      test('should serialize minimal filter options with null values', () {
        // Arrange
        final filterOptions = FilterOptions(
          minBedrooms: 1,
          maxBedrooms: 5,
          minPriceList: [500000],
          maxPriceList: [10000000],
        );

        // Act
        final json = filterOptions.toJson();

        // Assert
        expect(json['min_bedrooms'], equals(1));
        expect(json['max_bedrooms'], equals(5));
        expect(json['min_price_list'], equals([500000]));
        expect(json['max_price_list'], equals([10000000]));
        expect(json['property_types'], isNull);
        expect(json['amenities'], isNull);
        expect(json['sortings'], isNull);
        expect(json['sale_types'], isNull);
      });
    });

    group('JSON Serialization Validation', () {
      test('should serialize basic fields correctly', () {
        // Arrange
        final filterOptions = FilterOptions.fromJson(sampleFilterOptionsJson);

        // Act
        final json = filterOptions.toJson();

        // Assert - Basic fields should be serialized correctly
        expect(json['min_bedrooms'], equals(filterOptions.minBedrooms));
        expect(json['max_bedrooms'], equals(filterOptions.maxBedrooms));
        expect(json['min_price_list'], equals(filterOptions.minPriceList));
        expect(json['max_price_list'], equals(filterOptions.maxPriceList));
      });

      test('should handle list fields in serialization', () {
        // Arrange
        final filterOptions = FilterOptions.fromJson(sampleFilterOptionsJson);

        // Act
        final json = filterOptions.toJson();

        // Assert - List fields should be present
        expect(json['property_types'], isNotNull);
        expect(json['amenities'], isNotNull);
        expect(json['sortings'], isNotNull);
      });
    });

    group('Edge Cases', () {
      test('should handle malformed JSON gracefully', () {
        // Arrange
        final malformedJson = {
          'min_bedrooms': 'not-a-number', // Should be int
          'max_bedrooms': 5,
          'min_price_list': [500000],
          'max_price_list': [10000000],
        };

        // Act & Assert
        expect(() => FilterOptions.fromJson(malformedJson), throwsA(isA<TypeError>()));
      });

      test('should handle missing required fields', () {
        // Arrange
        final incompleteJson = {
          'min_bedrooms': 1,
          // Missing other required fields
        };

        // Act & Assert
        expect(() => FilterOptions.fromJson(incompleteJson), throwsA(isA<TypeError>()));
      });

      test('should handle invalid array types', () {
        // Arrange
        final jsonWithInvalidArrays = {
          'min_bedrooms': 1,
          'max_bedrooms': 5,
          'min_price_list': 'not-an-array', // Should be List<int>
          'max_price_list': [10000000],
        };

        // Act & Assert
        expect(() => FilterOptions.fromJson(jsonWithInvalidArrays), throwsA(isA<TypeError>()));
      });
    });
  });

  group('Amenity Tests', () {
    const sampleAmenityJson = {
      'id': 101,
      'name': 'Swimming Pool',
      'image_path': '/images/pool.jpg'
    };

    const minimalAmenityJson = {
      'id': 102,
      'name': 'Gym',
    };

    group('JSON Deserialization', () {
      test('should deserialize complete amenity from JSON', () {
        // Act
        final amenity = Amenity.fromJson(sampleAmenityJson);

        // Assert
        expect(amenity.id, equals(101));
        expect(amenity.name, equals('Swimming Pool'));
        expect(amenity.imagePath, equals('/images/pool.jpg'));
      });

      test('should deserialize minimal amenity without image path', () {
        // Act
        final amenity = Amenity.fromJson(minimalAmenityJson);

        // Assert
        expect(amenity.id, equals(102));
        expect(amenity.name, equals('Gym'));
        expect(amenity.imagePath, isNull);
      });
    });

    group('JSON Serialization', () {
      test('should serialize complete amenity to JSON', () {
        // Arrange
        final amenity = Amenity(id: 101, name: 'Swimming Pool', imagePath: '/images/pool.jpg');

        // Act
        final json = amenity.toJson();

        // Assert
        expect(json['id'], equals(101));
        expect(json['name'], equals('Swimming Pool'));
        expect(json['image_path'], equals('/images/pool.jpg'));
      });

      test('should serialize minimal amenity with null image path', () {
        // Arrange
        final amenity = Amenity(id: 102, name: 'Gym');

        // Act
        final json = amenity.toJson();

        // Assert
        expect(json['id'], equals(102));
        expect(json['name'], equals('Gym'));
        expect(json['image_path'], isNull);
      });
    });
  });

  group('SortOption Tests', () {
    const sampleSortOptionJson = {
      'key': 'price',
      'value': 'Price',
      'direction': 'asc'
    };

    group('JSON Deserialization', () {
      test('should deserialize sort option from JSON', () {
        // Act
        final sortOption = SortOption.fromJson(sampleSortOptionJson);

        // Assert
        expect(sortOption.key, equals('price'));
        expect(sortOption.value, equals('Price'));
        expect(sortOption.direction, equals('asc'));
      });
    });

    group('JSON Serialization', () {
      test('should serialize sort option to JSON', () {
        // Arrange
        final sortOption = SortOption(key: 'price', value: 'Price', direction: 'asc');

        // Act
        final json = sortOption.toJson();

        // Assert
        expect(json['key'], equals('price'));
        expect(json['value'], equals('Price'));
        expect(json['direction'], equals('asc'));
      });
    });

    group('Round-trip Serialization', () {
      test('should maintain data integrity through round-trip conversion', () {
        // Arrange
        final originalSortOption = SortOption.fromJson(sampleSortOptionJson);

        // Act
        final json = originalSortOption.toJson();
        final deserializedSortOption = SortOption.fromJson(json);

        // Assert
        expect(deserializedSortOption.key, equals(originalSortOption.key));
        expect(deserializedSortOption.value, equals(originalSortOption.value));
        expect(deserializedSortOption.direction, equals(originalSortOption.direction));
      });
    });

    group('Direction Validation', () {
      test('should handle ascending direction', () {
        // Arrange
        final json = {
          'key': 'price',
          'value': 'Price',
          'direction': 'asc'
        };

        // Act
        final sortOption = SortOption.fromJson(json);

        // Assert
        expect(sortOption.direction, equals('asc'));
      });

      test('should handle descending direction', () {
        // Arrange
        final json = {
          'key': 'date',
          'value': 'Date Added',
          'direction': 'desc'
        };

        // Act
        final sortOption = SortOption.fromJson(json);

        // Assert
        expect(sortOption.direction, equals('desc'));
      });
    });
  });
}
