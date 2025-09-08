// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPropertyIsarCollection on Isar {
  IsarCollection<PropertyIsar> get propertyIsars => this.collection();
}

const PropertyIsarSchema = CollectionSchema(
  name: r'PropertyIsar',
  id: 6543024421285882090,
  properties: {
    r'areaId': PropertySchema(
      id: 0,
      name: r'areaId',
      type: IsarType.long,
    ),
    r'compoundId': PropertySchema(
      id: 1,
      name: r'compoundId',
      type: IsarType.long,
    ),
    r'currency': PropertySchema(
      id: 2,
      name: r'currency',
      type: IsarType.string,
    ),
    r'developerId': PropertySchema(
      id: 3,
      name: r'developerId',
      type: IsarType.long,
    ),
    r'finishing': PropertySchema(
      id: 4,
      name: r'finishing',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 5,
      name: r'id',
      type: IsarType.long,
    ),
    r'image': PropertySchema(
      id: 6,
      name: r'image',
      type: IsarType.string,
    ),
    r'isFavorite': PropertySchema(
      id: 7,
      name: r'isFavorite',
      type: IsarType.bool,
    ),
    r'maxInstallmentYears': PropertySchema(
      id: 8,
      name: r'maxInstallmentYears',
      type: IsarType.long,
    ),
    r'maxInstallmentYearsMonths': PropertySchema(
      id: 9,
      name: r'maxInstallmentYearsMonths',
      type: IsarType.string,
    ),
    r'maxPrice': PropertySchema(
      id: 10,
      name: r'maxPrice',
      type: IsarType.double,
    ),
    r'maxUnitArea': PropertySchema(
      id: 11,
      name: r'maxUnitArea',
      type: IsarType.double,
    ),
    r'minPrice': PropertySchema(
      id: 12,
      name: r'minPrice',
      type: IsarType.double,
    ),
    r'minUnitArea': PropertySchema(
      id: 13,
      name: r'minUnitArea',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 14,
      name: r'name',
      type: IsarType.string,
    ),
    r'propertyTypeId': PropertySchema(
      id: 15,
      name: r'propertyTypeId',
      type: IsarType.long,
    ),
    r'slug': PropertySchema(
      id: 16,
      name: r'slug',
      type: IsarType.string,
    )
  },
  estimateSize: _propertyIsarEstimateSize,
  serialize: _propertyIsarSerialize,
  deserialize: _propertyIsarDeserialize,
  deserializeProp: _propertyIsarDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _propertyIsarGetId,
  getLinks: _propertyIsarGetLinks,
  attach: _propertyIsarAttach,
  version: '3.1.0+1',
);

int _propertyIsarEstimateSize(
  PropertyIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.currency;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.finishing;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.image;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.maxInstallmentYearsMonths;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.slug;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _propertyIsarSerialize(
  PropertyIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.areaId);
  writer.writeLong(offsets[1], object.compoundId);
  writer.writeString(offsets[2], object.currency);
  writer.writeLong(offsets[3], object.developerId);
  writer.writeString(offsets[4], object.finishing);
  writer.writeLong(offsets[5], object.id);
  writer.writeString(offsets[6], object.image);
  writer.writeBool(offsets[7], object.isFavorite);
  writer.writeLong(offsets[8], object.maxInstallmentYears);
  writer.writeString(offsets[9], object.maxInstallmentYearsMonths);
  writer.writeDouble(offsets[10], object.maxPrice);
  writer.writeDouble(offsets[11], object.maxUnitArea);
  writer.writeDouble(offsets[12], object.minPrice);
  writer.writeDouble(offsets[13], object.minUnitArea);
  writer.writeString(offsets[14], object.name);
  writer.writeLong(offsets[15], object.propertyTypeId);
  writer.writeString(offsets[16], object.slug);
}

PropertyIsar _propertyIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PropertyIsar();
  object.areaId = reader.readLongOrNull(offsets[0]);
  object.compoundId = reader.readLongOrNull(offsets[1]);
  object.currency = reader.readStringOrNull(offsets[2]);
  object.developerId = reader.readLongOrNull(offsets[3]);
  object.finishing = reader.readStringOrNull(offsets[4]);
  object.id = reader.readLong(offsets[5]);
  object.image = reader.readStringOrNull(offsets[6]);
  object.isFavorite = reader.readBool(offsets[7]);
  object.isarId = id;
  object.maxInstallmentYears = reader.readLongOrNull(offsets[8]);
  object.maxInstallmentYearsMonths = reader.readStringOrNull(offsets[9]);
  object.maxPrice = reader.readDoubleOrNull(offsets[10]);
  object.maxUnitArea = reader.readDoubleOrNull(offsets[11]);
  object.minPrice = reader.readDoubleOrNull(offsets[12]);
  object.minUnitArea = reader.readDoubleOrNull(offsets[13]);
  object.name = reader.readString(offsets[14]);
  object.propertyTypeId = reader.readLongOrNull(offsets[15]);
  object.slug = reader.readStringOrNull(offsets[16]);
  return object;
}

P _propertyIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readDoubleOrNull(offset)) as P;
    case 12:
      return (reader.readDoubleOrNull(offset)) as P;
    case 13:
      return (reader.readDoubleOrNull(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readLongOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _propertyIsarGetId(PropertyIsar object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _propertyIsarGetLinks(PropertyIsar object) {
  return [];
}

void _propertyIsarAttach(
    IsarCollection<dynamic> col, Id id, PropertyIsar object) {
  object.isarId = id;
}

extension PropertyIsarQueryWhereSort
    on QueryBuilder<PropertyIsar, PropertyIsar, QWhere> {
  QueryBuilder<PropertyIsar, PropertyIsar, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PropertyIsarQueryWhere
    on QueryBuilder<PropertyIsar, PropertyIsar, QWhereClause> {
  QueryBuilder<PropertyIsar, PropertyIsar, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
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

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterWhereClause> isarIdBetween(
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

extension PropertyIsarQueryFilter
    on QueryBuilder<PropertyIsar, PropertyIsar, QFilterCondition> {
  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      areaIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'areaId',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      areaIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'areaId',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> areaIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'areaId',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      areaIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'areaId',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      areaIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'areaId',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> areaIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'areaId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      compoundIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'compoundId',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      compoundIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'compoundId',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      compoundIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'compoundId',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      compoundIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'compoundId',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      compoundIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'compoundId',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      compoundIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'compoundId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      currencyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currency',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      currencyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currency',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      currencyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      currencyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      currencyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      currencyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      currencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      currencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      currencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      currencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      developerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'developerId',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      developerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'developerId',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      developerIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'developerId',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      developerIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'developerId',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      developerIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'developerId',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      developerIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'developerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      finishingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'finishing',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      finishingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'finishing',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      finishingEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finishing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      finishingGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'finishing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      finishingLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'finishing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      finishingBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'finishing',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      finishingStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'finishing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      finishingEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'finishing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      finishingContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'finishing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      finishingMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'finishing',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      finishingIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finishing',
        value: '',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      finishingIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'finishing',
        value: '',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> idEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      imageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      imageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> imageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      imageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> imageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> imageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      imageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> imageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> imageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> imageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      imageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      imageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      isFavoriteEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFavorite',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
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

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
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

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxInstallmentYears',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxInstallmentYears',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxInstallmentYears',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxInstallmentYears',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxInstallmentYears',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxInstallmentYears',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsMonthsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxInstallmentYearsMonths',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsMonthsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxInstallmentYearsMonths',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsMonthsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxInstallmentYearsMonths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsMonthsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxInstallmentYearsMonths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsMonthsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxInstallmentYearsMonths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsMonthsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxInstallmentYearsMonths',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsMonthsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'maxInstallmentYearsMonths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsMonthsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'maxInstallmentYearsMonths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsMonthsContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'maxInstallmentYearsMonths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsMonthsMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'maxInstallmentYearsMonths',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsMonthsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxInstallmentYearsMonths',
        value: '',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxInstallmentYearsMonthsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'maxInstallmentYearsMonths',
        value: '',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxPriceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxPrice',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxPriceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxPrice',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxPriceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxPriceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxPriceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxPriceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxUnitAreaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxUnitArea',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxUnitAreaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxUnitArea',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxUnitAreaEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxUnitArea',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxUnitAreaGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxUnitArea',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxUnitAreaLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxUnitArea',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      maxUnitAreaBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxUnitArea',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      minPriceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'minPrice',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      minPriceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'minPrice',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      minPriceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      minPriceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      minPriceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      minPriceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      minUnitAreaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'minUnitArea',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      minUnitAreaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'minUnitArea',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      minUnitAreaEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minUnitArea',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      minUnitAreaGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minUnitArea',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      minUnitAreaLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minUnitArea',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      minUnitAreaBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minUnitArea',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
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

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
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

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      propertyTypeIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'propertyTypeId',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      propertyTypeIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'propertyTypeId',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      propertyTypeIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'propertyTypeId',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      propertyTypeIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'propertyTypeId',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      propertyTypeIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'propertyTypeId',
        value: value,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      propertyTypeIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'propertyTypeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> slugIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'slug',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      slugIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'slug',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> slugEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'slug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      slugGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'slug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> slugLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'slug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> slugBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'slug',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      slugStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'slug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> slugEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'slug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> slugContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'slug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition> slugMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'slug',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      slugIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'slug',
        value: '',
      ));
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterFilterCondition>
      slugIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'slug',
        value: '',
      ));
    });
  }
}

extension PropertyIsarQueryObject
    on QueryBuilder<PropertyIsar, PropertyIsar, QFilterCondition> {}

extension PropertyIsarQueryLinks
    on QueryBuilder<PropertyIsar, PropertyIsar, QFilterCondition> {}

extension PropertyIsarQuerySortBy
    on QueryBuilder<PropertyIsar, PropertyIsar, QSortBy> {
  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByAreaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaId', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByAreaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaId', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByCompoundId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compoundId', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      sortByCompoundIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compoundId', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByDeveloperId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'developerId', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      sortByDeveloperIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'developerId', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByFinishing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishing', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByFinishingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishing', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      sortByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      sortByMaxInstallmentYears() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxInstallmentYears', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      sortByMaxInstallmentYearsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxInstallmentYears', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      sortByMaxInstallmentYearsMonths() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxInstallmentYearsMonths', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      sortByMaxInstallmentYearsMonthsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxInstallmentYearsMonths', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByMaxPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxPrice', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByMaxPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxPrice', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByMaxUnitArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxUnitArea', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      sortByMaxUnitAreaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxUnitArea', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByMinPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minPrice', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByMinPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minPrice', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByMinUnitArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minUnitArea', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      sortByMinUnitAreaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minUnitArea', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      sortByPropertyTypeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propertyTypeId', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      sortByPropertyTypeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propertyTypeId', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortBySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> sortBySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.desc);
    });
  }
}

extension PropertyIsarQuerySortThenBy
    on QueryBuilder<PropertyIsar, PropertyIsar, QSortThenBy> {
  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByAreaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaId', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByAreaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaId', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByCompoundId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compoundId', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      thenByCompoundIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compoundId', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByDeveloperId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'developerId', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      thenByDeveloperIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'developerId', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByFinishing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishing', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByFinishingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishing', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      thenByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      thenByMaxInstallmentYears() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxInstallmentYears', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      thenByMaxInstallmentYearsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxInstallmentYears', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      thenByMaxInstallmentYearsMonths() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxInstallmentYearsMonths', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      thenByMaxInstallmentYearsMonthsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxInstallmentYearsMonths', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByMaxPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxPrice', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByMaxPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxPrice', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByMaxUnitArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxUnitArea', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      thenByMaxUnitAreaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxUnitArea', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByMinPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minPrice', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByMinPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minPrice', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByMinUnitArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minUnitArea', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      thenByMinUnitAreaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minUnitArea', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      thenByPropertyTypeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propertyTypeId', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy>
      thenByPropertyTypeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propertyTypeId', Sort.desc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenBySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.asc);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QAfterSortBy> thenBySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.desc);
    });
  }
}

extension PropertyIsarQueryWhereDistinct
    on QueryBuilder<PropertyIsar, PropertyIsar, QDistinct> {
  QueryBuilder<PropertyIsar, PropertyIsar, QDistinct> distinctByAreaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'areaId');
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QDistinct> distinctByCompoundId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'compoundId');
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QDistinct> distinctByCurrency(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QDistinct> distinctByDeveloperId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'developerId');
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QDistinct> distinctByFinishing(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'finishing', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QDistinct> distinctById() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id');
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QDistinct> distinctByImage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'image', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QDistinct> distinctByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorite');
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QDistinct>
      distinctByMaxInstallmentYears() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxInstallmentYears');
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QDistinct>
      distinctByMaxInstallmentYearsMonths({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxInstallmentYearsMonths',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QDistinct> distinctByMaxPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxPrice');
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QDistinct> distinctByMaxUnitArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxUnitArea');
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QDistinct> distinctByMinPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minPrice');
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QDistinct> distinctByMinUnitArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minUnitArea');
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QDistinct>
      distinctByPropertyTypeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'propertyTypeId');
    });
  }

  QueryBuilder<PropertyIsar, PropertyIsar, QDistinct> distinctBySlug(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'slug', caseSensitive: caseSensitive);
    });
  }
}

extension PropertyIsarQueryProperty
    on QueryBuilder<PropertyIsar, PropertyIsar, QQueryProperty> {
  QueryBuilder<PropertyIsar, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<PropertyIsar, int?, QQueryOperations> areaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'areaId');
    });
  }

  QueryBuilder<PropertyIsar, int?, QQueryOperations> compoundIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'compoundId');
    });
  }

  QueryBuilder<PropertyIsar, String?, QQueryOperations> currencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currency');
    });
  }

  QueryBuilder<PropertyIsar, int?, QQueryOperations> developerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'developerId');
    });
  }

  QueryBuilder<PropertyIsar, String?, QQueryOperations> finishingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'finishing');
    });
  }

  QueryBuilder<PropertyIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PropertyIsar, String?, QQueryOperations> imageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image');
    });
  }

  QueryBuilder<PropertyIsar, bool, QQueryOperations> isFavoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorite');
    });
  }

  QueryBuilder<PropertyIsar, int?, QQueryOperations>
      maxInstallmentYearsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxInstallmentYears');
    });
  }

  QueryBuilder<PropertyIsar, String?, QQueryOperations>
      maxInstallmentYearsMonthsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxInstallmentYearsMonths');
    });
  }

  QueryBuilder<PropertyIsar, double?, QQueryOperations> maxPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxPrice');
    });
  }

  QueryBuilder<PropertyIsar, double?, QQueryOperations> maxUnitAreaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxUnitArea');
    });
  }

  QueryBuilder<PropertyIsar, double?, QQueryOperations> minPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minPrice');
    });
  }

  QueryBuilder<PropertyIsar, double?, QQueryOperations> minUnitAreaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minUnitArea');
    });
  }

  QueryBuilder<PropertyIsar, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<PropertyIsar, int?, QQueryOperations> propertyTypeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'propertyTypeId');
    });
  }

  QueryBuilder<PropertyIsar, String?, QQueryOperations> slugProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'slug');
    });
  }
}
