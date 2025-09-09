import 'package:injectable/injectable.dart';
import 'package:nawy_app/app/core/constants/api_constants.dart';
import 'package:nawy_app/app/core/utils/dio_client.dart';
import 'package:nawy_app/app/core/utils/error_handler.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/area_dto.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/compound_dto.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/filter_options.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/search_response.dart';

@singleton
class PropertyRemoteSource {
  final DioClient _dioClient;

  PropertyRemoteSource(this._dioClient);

  Future<List<AreaDto>> getAreas() async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final response = await _dioClient.dio.get(ApiConstants.areas);
        final List<dynamic> data = response.data;
        return data.map((json) => AreaDto.fromJson(json)).toList();
      },
      const Duration(seconds: 10),
      'GetAreas',
    );
  }

  Future<List<CompoundDto>> getCompounds() async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final response = await _dioClient.dio.get(ApiConstants.compounds);
        final List<dynamic> data = response.data;
        return data.map((json) => CompoundDto.fromJson(json)).toList();
      },
      const Duration(seconds: 10),
      'GetCompounds',
    );
  }

  Future<FilterOptions> getFilterOptions() async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final response = await _dioClient.dio.get(ApiConstants.filterOptions);
        return FilterOptions.fromJson(response.data);
      },
      const Duration(seconds: 10),
      'GetFilterOptions',
    );
  }

  Future<SearchResponse> searchProperties({
    List<int>? areaIds,
    List<int>? compoundIds,
    int? minPrice,
    int? maxPrice,
    int? minBedrooms,
    int? maxBedrooms,
    List<int>? propertyTypeIds,
  }) async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        // Build query parameters
        final Map<String, dynamic> queryParams = {};

        if (areaIds != null && areaIds.isNotEmpty) {
          queryParams['area_ids'] = areaIds.join(',');
        }

        if (compoundIds != null && compoundIds.isNotEmpty) {
          queryParams['compound_ids'] = compoundIds.join(',');
        }

        if (minPrice != null) {
          queryParams['min_price'] = minPrice;
        }

        if (maxPrice != null) {
          queryParams['max_price'] = maxPrice;
        }

        if (minBedrooms != null) {
          queryParams['min_bedrooms'] = minBedrooms;
        }

        if (maxBedrooms != null) {
          queryParams['max_bedrooms'] = maxBedrooms;
        }

        if (propertyTypeIds != null && propertyTypeIds.isNotEmpty) {
          queryParams['property_type_ids'] = propertyTypeIds.join(',');
        }

        final response = await _dioClient.dio.get(
          ApiConstants.propertiesSearch,
          queryParameters: queryParams,
        );

        return SearchResponse.fromJson(response.data);
      },
      const Duration(seconds: 30),
      'SearchProperties',
    );
  }
}
