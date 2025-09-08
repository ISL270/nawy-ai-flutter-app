// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compound_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCompoundIsarCollection on Isar {
  IsarCollection<CompoundIsar> get compoundIsars => this.collection();
}

const CompoundIsarSchema = CollectionSchema(
  name: r'CompoundIsar',
  id: -6747846652883056758,
  properties: {
    r'areaId': PropertySchema(
      id: 0,
      name: r'areaId',
      type: IsarType.long,
    ),
    r'developerId': PropertySchema(
      id: 1,
      name: r'developerId',
      type: IsarType.long,
    ),
    r'hasOffers': PropertySchema(
      id: 2,
      name: r'hasOffers',
      type: IsarType.bool,
    ),
    r'id': PropertySchema(
      id: 3,
      name: r'id',
      type: IsarType.long,
    ),
    r'imagePath': PropertySchema(
      id: 4,
      name: r'imagePath',
      type: IsarType.string,
    ),
    r'isFavorite': PropertySchema(
      id: 5,
      name: r'isFavorite',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 6,
      name: r'name',
      type: IsarType.string,
    ),
    r'nawyOrganizationId': PropertySchema(
      id: 7,
      name: r'nawyOrganizationId',
      type: IsarType.long,
    ),
    r'slug': PropertySchema(
      id: 8,
      name: r'slug',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 9,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _compoundIsarEstimateSize,
  serialize: _compoundIsarSerialize,
  deserialize: _compoundIsarDeserialize,
  deserializeProp: _compoundIsarDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _compoundIsarGetId,
  getLinks: _compoundIsarGetLinks,
  attach: _compoundIsarAttach,
  version: '3.1.0+1',
);

int _compoundIsarEstimateSize(
  CompoundIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.imagePath;
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

void _compoundIsarSerialize(
  CompoundIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.areaId);
  writer.writeLong(offsets[1], object.developerId);
  writer.writeBool(offsets[2], object.hasOffers);
  writer.writeLong(offsets[3], object.id);
  writer.writeString(offsets[4], object.imagePath);
  writer.writeBool(offsets[5], object.isFavorite);
  writer.writeString(offsets[6], object.name);
  writer.writeLong(offsets[7], object.nawyOrganizationId);
  writer.writeString(offsets[8], object.slug);
  writer.writeDateTime(offsets[9], object.updatedAt);
}

CompoundIsar _compoundIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CompoundIsar();
  object.areaId = reader.readLong(offsets[0]);
  object.developerId = reader.readLongOrNull(offsets[1]);
  object.hasOffers = reader.readBool(offsets[2]);
  object.id = reader.readLong(offsets[3]);
  object.imagePath = reader.readStringOrNull(offsets[4]);
  object.isFavorite = reader.readBool(offsets[5]);
  object.isarId = id;
  object.name = reader.readString(offsets[6]);
  object.nawyOrganizationId = reader.readLongOrNull(offsets[7]);
  object.slug = reader.readStringOrNull(offsets[8]);
  object.updatedAt = reader.readDateTimeOrNull(offsets[9]);
  return object;
}

P _compoundIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _compoundIsarGetId(CompoundIsar object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _compoundIsarGetLinks(CompoundIsar object) {
  return [];
}

void _compoundIsarAttach(
    IsarCollection<dynamic> col, Id id, CompoundIsar object) {
  object.isarId = id;
}

extension CompoundIsarQueryWhereSort
    on QueryBuilder<CompoundIsar, CompoundIsar, QWhere> {
  QueryBuilder<CompoundIsar, CompoundIsar, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CompoundIsarQueryWhere
    on QueryBuilder<CompoundIsar, CompoundIsar, QWhereClause> {
  QueryBuilder<CompoundIsar, CompoundIsar, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterWhereClause> isarIdBetween(
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

extension CompoundIsarQueryFilter
    on QueryBuilder<CompoundIsar, CompoundIsar, QFilterCondition> {
  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> areaIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'areaId',
        value: value,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      areaIdGreaterThan(
    int value, {
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      areaIdLessThan(
    int value, {
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> areaIdBetween(
    int lower,
    int upper, {
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      developerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'developerId',
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      developerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'developerId',
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      developerIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'developerId',
        value: value,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      hasOffersEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasOffers',
        value: value,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> idEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      imagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imagePath',
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      imagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imagePath',
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      imagePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      imagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      imagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      imagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      imagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      imagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      imagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      imagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      imagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      imagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      isFavoriteEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFavorite',
        value: value,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> nameContains(
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      nawyOrganizationIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nawyOrganizationId',
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      nawyOrganizationIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nawyOrganizationId',
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      nawyOrganizationIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nawyOrganizationId',
        value: value,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      nawyOrganizationIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nawyOrganizationId',
        value: value,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      nawyOrganizationIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nawyOrganizationId',
        value: value,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      nawyOrganizationIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nawyOrganizationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> slugIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'slug',
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      slugIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'slug',
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> slugEqualTo(
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> slugLessThan(
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> slugBetween(
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> slugEndsWith(
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> slugContains(
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition> slugMatches(
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

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      slugIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'slug',
        value: '',
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      slugIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'slug',
        value: '',
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterFilterCondition>
      updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CompoundIsarQueryObject
    on QueryBuilder<CompoundIsar, CompoundIsar, QFilterCondition> {}

extension CompoundIsarQueryLinks
    on QueryBuilder<CompoundIsar, CompoundIsar, QFilterCondition> {}

extension CompoundIsarQuerySortBy
    on QueryBuilder<CompoundIsar, CompoundIsar, QSortBy> {
  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> sortByAreaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaId', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> sortByAreaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaId', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> sortByDeveloperId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'developerId', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy>
      sortByDeveloperIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'developerId', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> sortByHasOffers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasOffers', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> sortByHasOffersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasOffers', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> sortByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> sortByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> sortByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy>
      sortByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy>
      sortByNawyOrganizationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nawyOrganizationId', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy>
      sortByNawyOrganizationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nawyOrganizationId', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> sortBySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> sortBySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CompoundIsarQuerySortThenBy
    on QueryBuilder<CompoundIsar, CompoundIsar, QSortThenBy> {
  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenByAreaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaId', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenByAreaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaId', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenByDeveloperId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'developerId', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy>
      thenByDeveloperIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'developerId', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenByHasOffers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasOffers', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenByHasOffersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasOffers', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy>
      thenByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy>
      thenByNawyOrganizationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nawyOrganizationId', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy>
      thenByNawyOrganizationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nawyOrganizationId', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenBySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenBySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.desc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CompoundIsarQueryWhereDistinct
    on QueryBuilder<CompoundIsar, CompoundIsar, QDistinct> {
  QueryBuilder<CompoundIsar, CompoundIsar, QDistinct> distinctByAreaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'areaId');
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QDistinct> distinctByDeveloperId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'developerId');
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QDistinct> distinctByHasOffers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasOffers');
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QDistinct> distinctById() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id');
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QDistinct> distinctByImagePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QDistinct> distinctByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorite');
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QDistinct>
      distinctByNawyOrganizationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nawyOrganizationId');
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QDistinct> distinctBySlug(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'slug', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompoundIsar, CompoundIsar, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension CompoundIsarQueryProperty
    on QueryBuilder<CompoundIsar, CompoundIsar, QQueryProperty> {
  QueryBuilder<CompoundIsar, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CompoundIsar, int, QQueryOperations> areaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'areaId');
    });
  }

  QueryBuilder<CompoundIsar, int?, QQueryOperations> developerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'developerId');
    });
  }

  QueryBuilder<CompoundIsar, bool, QQueryOperations> hasOffersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasOffers');
    });
  }

  QueryBuilder<CompoundIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CompoundIsar, String?, QQueryOperations> imagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagePath');
    });
  }

  QueryBuilder<CompoundIsar, bool, QQueryOperations> isFavoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorite');
    });
  }

  QueryBuilder<CompoundIsar, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<CompoundIsar, int?, QQueryOperations>
      nawyOrganizationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nawyOrganizationId');
    });
  }

  QueryBuilder<CompoundIsar, String?, QQueryOperations> slugProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'slug');
    });
  }

  QueryBuilder<CompoundIsar, DateTime?, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
