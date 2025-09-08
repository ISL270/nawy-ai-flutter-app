import 'package:injectable/injectable.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/filter_options.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/search_response.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/property_remote_datasource.dart';
import 'package:nawy_app/app/features/search/domain/entities/area.dart';
import 'package:nawy_app/app/features/search/domain/entities/compound.dart';
import 'package:nawy_app/app/features/search/domain/property_repository.dart';

@Injectable(as: PropertyRepository)
class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyRemoteDataSource _remoteDataSource;

  PropertyRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Area>> getAreas() async {
    final areaDtos = await _remoteDataSource.getAreas();
    return areaDtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<List<Compound>> getCompounds() async {
    final compoundDtos = await _remoteDataSource.getCompounds();
    return compoundDtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<FilterOptions> getFilterOptions() async {
    return await _remoteDataSource.getFilterOptions();
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
    return await _remoteDataSource.searchProperties(
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
