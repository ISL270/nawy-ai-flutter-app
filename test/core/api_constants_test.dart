import 'package:flutter_test/flutter_test.dart';
import 'package:nawy_ai_app/app/core/constants/api_constants.dart';

void main() {
  group('ApiConstants', () {
    group('Base URL', () {
      testWidgets('should have correct base URL', (tester) async {
        expect(ApiConstants.baseUrl, equals('https://hiring-tasks.github.io/mobile-app-apis'));
      });

      testWidgets('should use HTTPS protocol', (tester) async {
        expect(ApiConstants.baseUrl, startsWith('https://'));
      });

      testWidgets('should have valid URL format', (tester) async {
        final uri = Uri.tryParse(ApiConstants.baseUrl);
        expect(uri, isNotNull);
        expect(uri!.isAbsolute, isTrue);
        expect(uri.hasScheme, isTrue);
        expect(uri.hasAuthority, isTrue);
      });

      testWidgets('should not have trailing slash', (tester) async {
        expect(ApiConstants.baseUrl, isNot(endsWith('/')));
      });
    });

    group('Endpoints', () {
      testWidgets('should have correct compounds endpoint', (tester) async {
        expect(ApiConstants.compounds, equals('/compounds.json'));
      });

      testWidgets('should have correct areas endpoint', (tester) async {
        expect(ApiConstants.areas, equals('/areas.json'));
      });

      testWidgets('should have correct filter options endpoint', (tester) async {
        expect(ApiConstants.filterOptions, equals('/properties-get-filter-options.json'));
      });

      testWidgets('should have correct properties search endpoint', (tester) async {
        expect(ApiConstants.propertiesSearch, equals('/properties-search.json'));
      });

      testWidgets('should all endpoints start with forward slash', (tester) async {
        expect(ApiConstants.compounds, startsWith('/'));
        expect(ApiConstants.areas, startsWith('/'));
        expect(ApiConstants.filterOptions, startsWith('/'));
        expect(ApiConstants.propertiesSearch, startsWith('/'));
      });

      testWidgets('should all endpoints end with .json', (tester) async {
        expect(ApiConstants.compounds, endsWith('.json'));
        expect(ApiConstants.areas, endsWith('.json'));
        expect(ApiConstants.filterOptions, endsWith('.json'));
        expect(ApiConstants.propertiesSearch, endsWith('.json'));
      });

      testWidgets('should have unique endpoint paths', (tester) async {
        final endpoints = [
          ApiConstants.compounds,
          ApiConstants.areas,
          ApiConstants.filterOptions,
          ApiConstants.propertiesSearch,
        ];

        final uniqueEndpoints = endpoints.toSet();
        expect(uniqueEndpoints.length, equals(endpoints.length));
      });
    });

    group('Full URL Construction', () {
      testWidgets('should construct valid full URLs', (tester) async {
        final compoundsUrl = ApiConstants.baseUrl + ApiConstants.compounds;
        final areasUrl = ApiConstants.baseUrl + ApiConstants.areas;
        final filterOptionsUrl = ApiConstants.baseUrl + ApiConstants.filterOptions;
        final propertiesSearchUrl = ApiConstants.baseUrl + ApiConstants.propertiesSearch;

        // Verify all URLs are valid
        expect(Uri.tryParse(compoundsUrl), isNotNull);
        expect(Uri.tryParse(areasUrl), isNotNull);
        expect(Uri.tryParse(filterOptionsUrl), isNotNull);
        expect(Uri.tryParse(propertiesSearchUrl), isNotNull);

        // Verify expected full URLs
        expect(compoundsUrl, equals('https://hiring-tasks.github.io/mobile-app-apis/compounds.json'));
        expect(areasUrl, equals('https://hiring-tasks.github.io/mobile-app-apis/areas.json'));
        expect(filterOptionsUrl, equals('https://hiring-tasks.github.io/mobile-app-apis/properties-get-filter-options.json'));
        expect(propertiesSearchUrl, equals('https://hiring-tasks.github.io/mobile-app-apis/properties-search.json'));
      });

      testWidgets('should construct URLs without double slashes', (tester) async {
        final fullUrls = [
          ApiConstants.baseUrl + ApiConstants.compounds,
          ApiConstants.baseUrl + ApiConstants.areas,
          ApiConstants.baseUrl + ApiConstants.filterOptions,
          ApiConstants.baseUrl + ApiConstants.propertiesSearch,
        ];

        for (final url in fullUrls) {
          // Should not have double slashes except after protocol
          final withoutProtocol = url.replaceFirst('https://', '');
          expect(withoutProtocol, isNot(contains('//')));
        }
      });
    });

    group('Timeout Values', () {
      testWidgets('should have correct connect timeout', (tester) async {
        expect(ApiConstants.connectTimeout, equals(30000));
      });

      testWidgets('should have correct receive timeout', (tester) async {
        expect(ApiConstants.receiveTimeout, equals(30000));
      });

      testWidgets('should have reasonable timeout values', (tester) async {
        // Timeouts should be positive and reasonable (between 5-60 seconds)
        expect(ApiConstants.connectTimeout, greaterThan(5000));
        expect(ApiConstants.connectTimeout, lessThanOrEqualTo(60000));
        
        expect(ApiConstants.receiveTimeout, greaterThan(5000));
        expect(ApiConstants.receiveTimeout, lessThanOrEqualTo(60000));
      });

      testWidgets('should have equal connect and receive timeouts', (tester) async {
        expect(ApiConstants.connectTimeout, equals(ApiConstants.receiveTimeout));
      });

      testWidgets('should have timeout values in milliseconds', (tester) async {
        // 30000 milliseconds = 30 seconds
        expect(ApiConstants.connectTimeout, equals(30 * 1000));
        expect(ApiConstants.receiveTimeout, equals(30 * 1000));
      });
    });

    group('Constants Immutability', () {
      testWidgets('should have immutable string constants', (tester) async {
        // Constants should be compile-time constants
        const baseUrl = ApiConstants.baseUrl;
        const compounds = ApiConstants.compounds;
        const areas = ApiConstants.areas;
        const filterOptions = ApiConstants.filterOptions;
        const propertiesSearch = ApiConstants.propertiesSearch;

        expect(baseUrl, isA<String>());
        expect(compounds, isA<String>());
        expect(areas, isA<String>());
        expect(filterOptions, isA<String>());
        expect(propertiesSearch, isA<String>());
      });

      testWidgets('should have immutable int constants', (tester) async {
        const connectTimeout = ApiConstants.connectTimeout;
        const receiveTimeout = ApiConstants.receiveTimeout;

        expect(connectTimeout, isA<int>());
        expect(receiveTimeout, isA<int>());
      });
    });

    group('API Endpoint Naming', () {
      testWidgets('should follow consistent naming conventions', (tester) async {
        // All endpoints should use kebab-case and be descriptive
        expect(ApiConstants.compounds, matches(r'^/[a-z-]+\.json$'));
        expect(ApiConstants.areas, matches(r'^/[a-z-]+\.json$'));
        expect(ApiConstants.filterOptions, matches(r'^/[a-z-]+\.json$'));
        expect(ApiConstants.propertiesSearch, matches(r'^/[a-z-]+\.json$'));
      });

      testWidgets('should have descriptive endpoint names', (tester) async {
        // Endpoint names should clearly indicate their purpose
        expect(ApiConstants.compounds, contains('compounds'));
        expect(ApiConstants.areas, contains('areas'));
        expect(ApiConstants.filterOptions, contains('filter-options'));
        expect(ApiConstants.propertiesSearch, contains('properties-search'));
      });
    });

    group('Real-world Usage', () {
      testWidgets('should work with HTTP client libraries', (tester) async {
        // Simulate how these constants would be used with HTTP clients
        final endpoints = {
          'compounds': ApiConstants.baseUrl + ApiConstants.compounds,
          'areas': ApiConstants.baseUrl + ApiConstants.areas,
          'filterOptions': ApiConstants.baseUrl + ApiConstants.filterOptions,
          'propertiesSearch': ApiConstants.baseUrl + ApiConstants.propertiesSearch,
        };

        for (final entry in endpoints.entries) {
          final uri = Uri.parse(entry.value);
          expect(uri.isAbsolute, isTrue);
          expect(uri.scheme, equals('https'));
          expect(uri.host, equals('hiring-tasks.github.io'));
          expect(uri.path, startsWith('/mobile-app-apis/'));
          expect(uri.path, endsWith('.json'));
        }
      });

      testWidgets('should support query parameters', (tester) async {
        // Base URLs should support adding query parameters
        final baseUri = Uri.parse(ApiConstants.baseUrl + ApiConstants.propertiesSearch);
        final uriWithQuery = baseUri.replace(queryParameters: {
          'page': '1',
          'limit': '10',
        });

        expect(uriWithQuery.toString(), contains('?'));
        expect(uriWithQuery.toString(), contains('page=1'));
        expect(uriWithQuery.toString(), contains('limit=10'));
      });

      testWidgets('should work with different HTTP methods', (tester) async {
        // URLs should be valid for different HTTP methods
        final urls = [
          ApiConstants.baseUrl + ApiConstants.compounds,
          ApiConstants.baseUrl + ApiConstants.areas,
          ApiConstants.baseUrl + ApiConstants.filterOptions,
          ApiConstants.baseUrl + ApiConstants.propertiesSearch,
        ];

        for (final url in urls) {
          final uri = Uri.parse(url);
          
          // Should be valid for GET requests (most common for JSON APIs)
          expect(uri.isAbsolute, isTrue);
          expect(uri.hasScheme, isTrue);
          expect(uri.hasAuthority, isTrue);
        }
      });
    });

    group('Error Handling', () {
      testWidgets('should handle URL parsing edge cases', (tester) async {
        // Base URL should be parseable even with modifications
        final uri = Uri.parse(ApiConstants.baseUrl);
        
        expect(uri.scheme, equals('https'));
        expect(uri.host, isNotEmpty);
        expect(uri.path, isNotEmpty);
      });

      testWidgets('should handle endpoint concatenation safely', (tester) async {
        // Should not break when concatenating base URL with endpoints
        final endpoints = [
          ApiConstants.compounds,
          ApiConstants.areas,
          ApiConstants.filterOptions,
          ApiConstants.propertiesSearch,
        ];

        for (final endpoint in endpoints) {
          final fullUrl = ApiConstants.baseUrl + endpoint;
          expect(() => Uri.parse(fullUrl), returnsNormally);
          
          final uri = Uri.parse(fullUrl);
          expect(uri.isAbsolute, isTrue);
        }
      });
    });

    group('Performance', () {
      testWidgets('should have efficient constant access', (tester) async {
        // Multiple accesses should be efficient (compile-time constants)
        const url1 = ApiConstants.baseUrl;
        const url2 = ApiConstants.baseUrl;
        
        expect(identical(url1, url2), isTrue);
      });

      testWidgets('should minimize string concatenation overhead', (tester) async {
        // Constants should be designed for efficient concatenation
        expect(ApiConstants.baseUrl, isNot(endsWith('/')));
        expect(ApiConstants.compounds, startsWith('/'));
        
        // This ensures no double slashes when concatenating (except after protocol)
        final fullUrl = ApiConstants.baseUrl + ApiConstants.compounds;
        final withoutProtocol = fullUrl.replaceFirst('https://', '');
        expect(withoutProtocol, isNot(contains('//')));
      });
    });

    group('Configuration Completeness', () {
      testWidgets('should have all required API endpoints', (tester) async {
        // Verify all expected endpoints are defined
        expect(ApiConstants.compounds, isNotNull);
        expect(ApiConstants.areas, isNotNull);
        expect(ApiConstants.filterOptions, isNotNull);
        expect(ApiConstants.propertiesSearch, isNotNull);
      });

      testWidgets('should have all required timeout configurations', (tester) async {
        // Verify all timeout values are defined
        expect(ApiConstants.connectTimeout, isNotNull);
        expect(ApiConstants.receiveTimeout, isNotNull);
        
        expect(ApiConstants.connectTimeout, isA<int>());
        expect(ApiConstants.receiveTimeout, isA<int>());
      });

      testWidgets('should have complete API configuration', (tester) async {
        // Should have base URL and all endpoints needed for the app
        expect(ApiConstants.baseUrl, isNotNull);
        expect(ApiConstants.baseUrl, isNotEmpty);
        
        // Should cover all property search related endpoints
        expect(ApiConstants.compounds, isNotNull);
        expect(ApiConstants.areas, isNotNull);
        expect(ApiConstants.filterOptions, isNotNull);
        expect(ApiConstants.propertiesSearch, isNotNull);
      });
    });

    group('Documentation and Maintainability', () {
      testWidgets('should have clear constant organization', (tester) async {
        // Constants should be logically grouped
        // Base URL
        expect(ApiConstants.baseUrl, isA<String>());
        
        // Endpoints (all JSON files)
        final endpoints = [
          ApiConstants.compounds,
          ApiConstants.areas,
          ApiConstants.filterOptions,
          ApiConstants.propertiesSearch,
        ];
        
        for (final endpoint in endpoints) {
          expect(endpoint, endsWith('.json'));
        }
        
        // Timeouts (all integers in milliseconds)
        expect(ApiConstants.connectTimeout, isA<int>());
        expect(ApiConstants.receiveTimeout, isA<int>());
      });

      testWidgets('should be easy to modify and extend', (tester) async {
        // Structure should support easy addition of new endpoints
        expect(ApiConstants.baseUrl, isA<String>());
        
        // All endpoints follow the same pattern
        final endpoints = [
          ApiConstants.compounds,
          ApiConstants.areas,
          ApiConstants.filterOptions,
          ApiConstants.propertiesSearch,
        ];
        
        for (final endpoint in endpoints) {
          expect(endpoint, startsWith('/'));
          expect(endpoint, endsWith('.json'));
        }
      });
    });
  });
}
