// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_type_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPropertyTypeIsarCollection on Isar {
  IsarCollection<PropertyTypeIsar> get propertyTypeIsars => this.collection();
}

const PropertyTypeIsarSchema = CollectionSchema(
  name: r'PropertyTypeIsar',
  id: -7725429981630258072,
  properties: {
    r'hasLandArea': PropertySchema(
      id: 0,
      name: r'hasLandArea',
      type: IsarType.bool,
    ),
    r'hasMandatoryGardenArea': PropertySchema(
      id: 1,
      name: r'hasMandatoryGardenArea',
      type: IsarType.bool,
    ),
    r'iconUrl': PropertySchema(
      id: 2,
      name: r'iconUrl',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 3,
      name: r'id',
      type: IsarType.long,
    ),
    r'manualRanking': PropertySchema(
      id: 4,
      name: r'manualRanking',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _propertyTypeIsarEstimateSize,
  serialize: _propertyTypeIsarSerialize,
  deserialize: _propertyTypeIsarDeserialize,
  deserializeProp: _propertyTypeIsarDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _propertyTypeIsarGetId,
  getLinks: _propertyTypeIsarGetLinks,
  attach: _propertyTypeIsarAttach,
  version: '3.1.0+1',
);

int _propertyTypeIsarEstimateSize(
  PropertyTypeIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.iconUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _propertyTypeIsarSerialize(
  PropertyTypeIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.hasLandArea);
  writer.writeBool(offsets[1], object.hasMandatoryGardenArea);
  writer.writeString(offsets[2], object.iconUrl);
  writer.writeLong(offsets[3], object.id);
  writer.writeLong(offsets[4], object.manualRanking);
  writer.writeString(offsets[5], object.name);
}

PropertyTypeIsar _propertyTypeIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PropertyTypeIsar();
  object.hasLandArea = reader.readBool(offsets[0]);
  object.hasMandatoryGardenArea = reader.readBool(offsets[1]);
  object.iconUrl = reader.readStringOrNull(offsets[2]);
  object.id = reader.readLong(offsets[3]);
  object.isarId = id;
  object.manualRanking = reader.readLongOrNull(offsets[4]);
  object.name = reader.readString(offsets[5]);
  return object;
}

P _propertyTypeIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _propertyTypeIsarGetId(PropertyTypeIsar object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _propertyTypeIsarGetLinks(PropertyTypeIsar object) {
  return [];
}

void _propertyTypeIsarAttach(
    IsarCollection<dynamic> col, Id id, PropertyTypeIsar object) {
  object.isarId = id;
}

extension PropertyTypeIsarQueryWhereSort
    on QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QWhere> {
  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PropertyTypeIsarQueryWhere
    on QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QWhereClause> {
  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterWhereClause>
      isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PropertyTypeIsarQueryFilter
    on QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QFilterCondition> {
  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      hasLandAreaEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasLandArea',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      hasMandatoryGardenAreaEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasMandatoryGardenArea',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      iconUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'iconUrl',
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      iconUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'iconUrl',
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      iconUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      iconUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      iconUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      iconUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iconUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      iconUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'iconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      iconUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'iconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      iconUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'iconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      iconUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'iconUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      iconUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      iconUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'iconUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      idLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      manualRankingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'manualRanking',
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      manualRankingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'manualRanking',
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      manualRankingEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'manualRanking',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      manualRankingGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'manualRanking',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      manualRankingLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'manualRanking',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      manualRankingBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'manualRanking',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension PropertyTypeIsarQueryObject
    on QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QFilterCondition> {}

extension PropertyTypeIsarQueryLinks
    on QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QFilterCondition> {}

extension PropertyTypeIsarQuerySortBy
    on QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QSortBy> {
  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      sortByHasLandArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasLandArea', Sort.asc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      sortByHasLandAreaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasLandArea', Sort.desc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      sortByHasMandatoryGardenArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasMandatoryGardenArea', Sort.asc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      sortByHasMandatoryGardenAreaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasMandatoryGardenArea', Sort.desc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      sortByIconUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconUrl', Sort.asc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      sortByIconUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconUrl', Sort.desc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      sortByManualRanking() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualRanking', Sort.asc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      sortByManualRankingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualRanking', Sort.desc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension PropertyTypeIsarQuerySortThenBy
    on QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QSortThenBy> {
  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      thenByHasLandArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasLandArea', Sort.asc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      thenByHasLandAreaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasLandArea', Sort.desc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      thenByHasMandatoryGardenArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasMandatoryGardenArea', Sort.asc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      thenByHasMandatoryGardenAreaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasMandatoryGardenArea', Sort.desc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      thenByIconUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconUrl', Sort.asc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      thenByIconUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconUrl', Sort.desc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      thenByManualRanking() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualRanking', Sort.asc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      thenByManualRankingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualRanking', Sort.desc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension PropertyTypeIsarQueryWhereDistinct
    on QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QDistinct> {
  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QDistinct>
      distinctByHasLandArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasLandArea');
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QDistinct>
      distinctByHasMandatoryGardenArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasMandatoryGardenArea');
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QDistinct> distinctByIconUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QDistinct> distinctById() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id');
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QDistinct>
      distinctByManualRanking() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'manualRanking');
    });
  }

  QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension PropertyTypeIsarQueryProperty
    on QueryBuilder<PropertyTypeIsar, PropertyTypeIsar, QQueryProperty> {
  QueryBuilder<PropertyTypeIsar, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<PropertyTypeIsar, bool, QQueryOperations> hasLandAreaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasLandArea');
    });
  }

  QueryBuilder<PropertyTypeIsar, bool, QQueryOperations>
      hasMandatoryGardenAreaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasMandatoryGardenArea');
    });
  }

  QueryBuilder<PropertyTypeIsar, String?, QQueryOperations> iconUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconUrl');
    });
  }

  QueryBuilder<PropertyTypeIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PropertyTypeIsar, int?, QQueryOperations>
      manualRankingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'manualRanking');
    });
  }

  QueryBuilder<PropertyTypeIsar, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
