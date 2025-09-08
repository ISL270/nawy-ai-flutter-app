import 'package:nawy_app/app/features/search/data/sources/remote/models/filter_options.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/search_response.dart';
import 'package:nawy_app/app/features/search/domain/entities/area.dart';
import 'package:nawy_app/app/features/search/domain/entities/compound.dart';

abstract class PropertyRepository {
  Future<List<Area>> getAreas();
  Future<List<Compound>> getCompounds();
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
