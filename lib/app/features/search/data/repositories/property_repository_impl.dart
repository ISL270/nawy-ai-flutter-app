import '../../../../core/models/area/area.dart';
import '../../../../core/models/compound/compound.dart';
import '../models/filter_options.dart';
import '../models/search_response.dart';
import '../../domain/repositories/property_repository.dart';
import '../datasources/property_remote_datasource.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyRemoteDataSource _remoteDataSource;

  PropertyRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Area>> getAreas() async {
    try {
      final apiModels = await _remoteDataSource.getAreas();
      return apiModels.map((apiModel) => apiModel.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Compound>> getCompounds() async {
    try {
      final apiModels = await _remoteDataSource.getCompounds();
      return apiModels.map((apiModel) => apiModel.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FilterOptions> getFilterOptions() async {
    try {
      return await _remoteDataSource.getFilterOptions();
    } catch (e) {
      rethrow;
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
      return await _remoteDataSource.searchProperties(
        areaIds: areaIds,
        compoundIds: compoundIds,
        minPrice: minPrice,
        maxPrice: maxPrice,
        minBedrooms: minBedrooms,
        maxBedrooms: maxBedrooms,
        propertyTypeIds: propertyTypeIds,
      );
    } catch (e) {
      rethrow;
    }
  }
}
