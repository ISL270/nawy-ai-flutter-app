import 'package:dio/dio.dart';
import 'package:nawy_app/app/core/constants/api_constants.dart';
import 'package:nawy_app/app/core/utils/dio_client.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/area_dto.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/compound_dto.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/filter_options.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/search_response.dart';

abstract class PropertyRemoteDataSource {
  Future<List<AreaDto>> getAreas();
  Future<List<CompoundDto>> getCompounds();
  Future<FilterOptions> getFilterOptions();
  Future<SearchResponse> searchProperties({
    List<int>? areaIds,
    List<int>? compoundIds,
    int? minPrice,
    int? maxPrice,
    int? minBedrooms,
    int? maxBedrooms,
    List<int>? propertyTypeIds,
  });
}

class PropertyRemoteDataSourceImpl implements PropertyRemoteDataSource {
  final DioClient _dioClient;

  PropertyRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<AreaDto>> getAreas() async {
    try {
      final response = await _dioClient.dio.get(ApiConstants.areas);
      final List<dynamic> data = response.data;
      return data.map((json) => AreaDto.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<List<CompoundDto>> getCompounds() async {
    try {
      final response = await _dioClient.dio.get(ApiConstants.compounds);
      final List<dynamic> data = response.data;
      return data.map((json) => CompoundDto.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<FilterOptions> getFilterOptions() async {
    try {
      final response = await _dioClient.dio.get(ApiConstants.filterOptions);
      return FilterOptions.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<SearchResponse> searchProperties({
    List<int>? areaIds,
    List<int>? compoundIds,
    int? minPrice,
    int? maxPrice,
    int? minBedrooms,
    int? maxBedrooms,
    List<int>? propertyTypeIds,
  }) async {
    try {
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
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Exception _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout. Please check your internet connection.');
      case DioExceptionType.badResponse:
        return Exception('Server error: ${e.response?.statusCode}');
      case DioExceptionType.cancel:
        return Exception('Request was cancelled');
      case DioExceptionType.connectionError:
        return Exception('No internet connection');
      case DioExceptionType.unknown:
      default:
        return Exception('Something went wrong. Please try again.');
    }
  }
}
