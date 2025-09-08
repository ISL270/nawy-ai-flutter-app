import '../../../../core/models/area/area.dart';
import '../../../../core/models/compound/compound.dart';
import '../../data/models/filter_options.dart';
import '../../data/models/search_response.dart';

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
