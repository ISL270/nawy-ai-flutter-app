import 'package:injectable/injectable.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/filter_options.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/search_response.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/property_remote_source.dart';
import 'package:nawy_app/app/features/search/domain/models/area.dart';
import 'package:nawy_app/app/features/search/domain/models/compound.dart';

@singleton
class PropertyRepository {
  final PropertyRemoteSource _remoteSource;

  PropertyRepository(this._remoteSource);

  Future<List<Area>> getAreas() async {
    final areaDtos = await _remoteSource.getAreas();
    return areaDtos.map((dto) => dto.toEntity()).toList();
  }

  Future<List<Compound>> getCompounds() async {
    final compoundDtos = await _remoteSource.getCompounds();
    return compoundDtos.map((dto) => dto.toEntity()).toList();
  }

  Future<FilterOptions> getFilterOptions() async {
    return await _remoteSource.getFilterOptions();
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
    return await _remoteSource.searchProperties(
      areaIds: areaIds,
      compoundIds: compoundIds,
      minPrice: minPrice,
      maxPrice: maxPrice,
      minBedrooms: minBedrooms,
      maxBedrooms: maxBedrooms,
      propertyTypeIds: propertyTypeIds,
    );
  }
}
