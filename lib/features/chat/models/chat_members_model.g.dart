// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_members_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSingleMemberModelCollection on Isar {
  IsarCollection<SingleMemberModel> get singleMemberModels => this.collection();
}

const SingleMemberModelSchema = CollectionSchema(
  name: r'SingleMemberModel',
  id: 2400593514983036443,
  properties: {
    r'composedId': PropertySchema(
      id: 0,
      name: r'composedId',
      type: IsarType.object,
      target: r'ComposedId',
    ),
    r'content': PropertySchema(
      id: 1,
      name: r'content',
      type: IsarType.string,
    ),
    r'contentType': PropertySchema(
      id: 2,
      name: r'contentType',
      type: IsarType.long,
    ),
    r'from': PropertySchema(
      id: 3,
      name: r'from',
      type: IsarType.string,
    ),
    r'isDeletedAccount': PropertySchema(
      id: 4,
      name: r'isDeletedAccount',
      type: IsarType.bool,
    ),
    r'isGroup': PropertySchema(
      id: 5,
      name: r'isGroup',
      type: IsarType.bool,
    ),
    r'jid': PropertySchema(
      id: 6,
      name: r'jid',
      type: IsarType.string,
    ),
    r'lastMessageId': PropertySchema(
      id: 7,
      name: r'lastMessageId',
      type: IsarType.string,
    ),
    r'lastMessageIdAvailableInLocal': PropertySchema(
      id: 8,
      name: r'lastMessageIdAvailableInLocal',
      type: IsarType.string,
    ),
    r'lastSyncTime': PropertySchema(
      id: 9,
      name: r'lastSyncTime',
      type: IsarType.long,
    ),
    r'timeSend': PropertySchema(
      id: 10,
      name: r'timeSend',
      type: IsarType.long,
    ),
    r'to': PropertySchema(
      id: 11,
      name: r'to',
      type: IsarType.string,
    ),
    r'toUserName': PropertySchema(
      id: 12,
      name: r'toUserName',
      type: IsarType.string,
    ),
    r'toUserStatus': PropertySchema(
      id: 13,
      name: r'toUserStatus',
      type: IsarType.long,
    ),
    r'unreadCount': PropertySchema(
      id: 14,
      name: r'unreadCount',
      type: IsarType.long,
    ),
    r'userId': PropertySchema(
      id: 15,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _singleMemberModelEstimateSize,
  serialize: _singleMemberModelSerialize,
  deserialize: _singleMemberModelDeserialize,
  deserializeProp: _singleMemberModelDeserializeProp,
  idName: r'boxId',
  indexes: {},
  links: {},
  embeddedSchemas: {r'ComposedId': ComposedIdSchema},
  getId: _singleMemberModelGetId,
  getLinks: _singleMemberModelGetLinks,
  attach: _singleMemberModelAttach,
  version: '3.1.0+1',
);

int _singleMemberModelEstimateSize(
  SingleMemberModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.composedId;
    if (value != null) {
      bytesCount += 3 +
          ComposedIdSchema.estimateSize(
              value, allOffsets[ComposedId]!, allOffsets);
    }
  }
  {
    final value = object.content;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.from;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.jid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastMessageId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastMessageIdAvailableInLocal;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.to;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.toUserName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.userId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _singleMemberModelSerialize(
  SingleMemberModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<ComposedId>(
    offsets[0],
    allOffsets,
    ComposedIdSchema.serialize,
    object.composedId,
  );
  writer.writeString(offsets[1], object.content);
  writer.writeLong(offsets[2], object.contentType);
  writer.writeString(offsets[3], object.from);
  writer.writeBool(offsets[4], object.isDeletedAccount);
  writer.writeBool(offsets[5], object.isGroup);
  writer.writeString(offsets[6], object.jid);
  writer.writeString(offsets[7], object.lastMessageId);
  writer.writeString(offsets[8], object.lastMessageIdAvailableInLocal);
  writer.writeLong(offsets[9], object.lastSyncTime);
  writer.writeLong(offsets[10], object.timeSend);
  writer.writeString(offsets[11], object.to);
  writer.writeString(offsets[12], object.toUserName);
  writer.writeLong(offsets[13], object.toUserStatus);
  writer.writeLong(offsets[14], object.unreadCount);
  writer.writeString(offsets[15], object.userId);
}

SingleMemberModel _singleMemberModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SingleMemberModel(
    boxId: id,
    composedId: reader.readObjectOrNull<ComposedId>(
      offsets[0],
      ComposedIdSchema.deserialize,
      allOffsets,
    ),
    content: reader.readStringOrNull(offsets[1]),
    contentType: reader.readLongOrNull(offsets[2]),
    from: reader.readStringOrNull(offsets[3]),
    isGroup: reader.readBoolOrNull(offsets[5]),
    jid: reader.readStringOrNull(offsets[6]),
    lastMessageId: reader.readStringOrNull(offsets[7]),
    lastMessageIdAvailableInLocal: reader.readStringOrNull(offsets[8]),
    lastSyncTime: reader.readLongOrNull(offsets[9]),
    timeSend: reader.readLongOrNull(offsets[10]),
    to: reader.readStringOrNull(offsets[11]),
    toUserName: reader.readStringOrNull(offsets[12]),
    toUserStatus: reader.readLongOrNull(offsets[13]),
    unreadCount: reader.readLongOrNull(offsets[14]),
    userId: reader.readStringOrNull(offsets[15]),
  );
  return object;
}

P _singleMemberModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<ComposedId>(
        offset,
        ComposedIdSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _singleMemberModelGetId(SingleMemberModel object) {
  return object.boxId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _singleMemberModelGetLinks(
    SingleMemberModel object) {
  return [];
}

void _singleMemberModelAttach(
    IsarCollection<dynamic> col, Id id, SingleMemberModel object) {
  object.boxId = id;
}

extension SingleMemberModelQueryWhereSort
    on QueryBuilder<SingleMemberModel, SingleMemberModel, QWhere> {
  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterWhere> anyBoxId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SingleMemberModelQueryWhere
    on QueryBuilder<SingleMemberModel, SingleMemberModel, QWhereClause> {
  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterWhereClause>
      boxIdEqualTo(Id boxId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: boxId,
        upper: boxId,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterWhereClause>
      boxIdNotEqualTo(Id boxId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: boxId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: boxId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: boxId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: boxId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterWhereClause>
      boxIdGreaterThan(Id boxId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: boxId, includeLower: include),
      );
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterWhereClause>
      boxIdLessThan(Id boxId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: boxId, includeUpper: include),
      );
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterWhereClause>
      boxIdBetween(
    Id lowerBoxId,
    Id upperBoxId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerBoxId,
        includeLower: includeLower,
        upper: upperBoxId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SingleMemberModelQueryFilter
    on QueryBuilder<SingleMemberModel, SingleMemberModel, QFilterCondition> {
  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      boxIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'boxId',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      boxIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'boxId',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      boxIdEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boxId',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      boxIdGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boxId',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      boxIdLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boxId',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      boxIdBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boxId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      composedIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'composedId',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      composedIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'composedId',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'content',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'content',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contentType',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contentType',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentTypeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentType',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentTypeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentType',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentTypeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentType',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      contentTypeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      fromIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'from',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      fromIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'from',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      fromEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      fromGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      fromLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      fromBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'from',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      fromStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      fromEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      fromContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      fromMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'from',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      fromIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'from',
        value: '',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      fromIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'from',
        value: '',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      isDeletedAccountEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeletedAccount',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      isGroupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isGroup',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      isGroupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isGroup',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      isGroupEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      jidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'jid',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      jidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'jid',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      jidEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      jidGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      jidLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      jidBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      jidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'jid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      jidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'jid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      jidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'jid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      jidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'jid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      jidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jid',
        value: '',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      jidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'jid',
        value: '',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastMessageId',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastMessageId',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastMessageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastMessageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessageId',
        value: '',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastMessageId',
        value: '',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdAvailableInLocalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastMessageIdAvailableInLocal',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdAvailableInLocalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastMessageIdAvailableInLocal',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdAvailableInLocalEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessageIdAvailableInLocal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdAvailableInLocalGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastMessageIdAvailableInLocal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdAvailableInLocalLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastMessageIdAvailableInLocal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdAvailableInLocalBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastMessageIdAvailableInLocal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdAvailableInLocalStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastMessageIdAvailableInLocal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdAvailableInLocalEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastMessageIdAvailableInLocal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdAvailableInLocalContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastMessageIdAvailableInLocal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdAvailableInLocalMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastMessageIdAvailableInLocal',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdAvailableInLocalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessageIdAvailableInLocal',
        value: '',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastMessageIdAvailableInLocalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastMessageIdAvailableInLocal',
        value: '',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastSyncTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastSyncTime',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastSyncTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastSyncTime',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastSyncTimeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSyncTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastSyncTimeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSyncTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastSyncTimeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSyncTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      lastSyncTimeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSyncTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      timeSendIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timeSend',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      timeSendIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timeSend',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      timeSendEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeSend',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      timeSendGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeSend',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      timeSendLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeSend',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      timeSendBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeSend',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'to',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'to',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'to',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'to',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'to',
        value: '',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'to',
        value: '',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'toUserName',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'toUserName',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toUserName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toUserName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toUserName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toUserName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'toUserName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'toUserName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'toUserName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'toUserName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toUserName',
        value: '',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'toUserName',
        value: '',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserStatusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'toUserStatus',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserStatusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'toUserStatus',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserStatusEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toUserStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserStatusGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toUserStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserStatusLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toUserStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      toUserStatusBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toUserStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      unreadCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'unreadCount',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      unreadCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'unreadCount',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      unreadCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unreadCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      unreadCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unreadCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      unreadCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unreadCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      unreadCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unreadCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      userIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      userIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      userIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      userIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension SingleMemberModelQueryObject
    on QueryBuilder<SingleMemberModel, SingleMemberModel, QFilterCondition> {
  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterFilterCondition>
      composedId(FilterQuery<ComposedId> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'composedId');
    });
  }
}

extension SingleMemberModelQueryLinks
    on QueryBuilder<SingleMemberModel, SingleMemberModel, QFilterCondition> {}

extension SingleMemberModelQuerySortBy
    on QueryBuilder<SingleMemberModel, SingleMemberModel, QSortBy> {
  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByContentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByIsDeletedAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeletedAccount', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByIsDeletedAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeletedAccount', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByIsGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy> sortByJid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jid', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByJidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jid', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByLastMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageId', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByLastMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageId', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByLastMessageIdAvailableInLocal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageIdAvailableInLocal', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByLastMessageIdAvailableInLocalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageIdAvailableInLocal', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByLastSyncTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncTime', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByLastSyncTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncTime', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByTimeSend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeSend', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByTimeSendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeSend', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy> sortByTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'to', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'to', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByToUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toUserName', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByToUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toUserName', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByToUserStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toUserStatus', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByToUserStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toUserStatus', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByUnreadCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadCount', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByUnreadCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadCount', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension SingleMemberModelQuerySortThenBy
    on QueryBuilder<SingleMemberModel, SingleMemberModel, QSortThenBy> {
  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByBoxId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boxId', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByBoxIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boxId', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByContentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByIsDeletedAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeletedAccount', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByIsDeletedAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeletedAccount', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByIsGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy> thenByJid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jid', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByJidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jid', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByLastMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageId', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByLastMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageId', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByLastMessageIdAvailableInLocal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageIdAvailableInLocal', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByLastMessageIdAvailableInLocalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageIdAvailableInLocal', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByLastSyncTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncTime', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByLastSyncTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncTime', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByTimeSend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeSend', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByTimeSendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeSend', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy> thenByTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'to', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'to', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByToUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toUserName', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByToUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toUserName', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByToUserStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toUserStatus', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByToUserStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toUserStatus', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByUnreadCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadCount', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByUnreadCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadCount', Sort.desc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension SingleMemberModelQueryWhereDistinct
    on QueryBuilder<SingleMemberModel, SingleMemberModel, QDistinct> {
  QueryBuilder<SingleMemberModel, SingleMemberModel, QDistinct>
      distinctByContent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QDistinct>
      distinctByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentType');
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QDistinct> distinctByFrom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'from', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QDistinct>
      distinctByIsDeletedAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeletedAccount');
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QDistinct>
      distinctByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isGroup');
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QDistinct> distinctByJid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QDistinct>
      distinctByLastMessageId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastMessageId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QDistinct>
      distinctByLastMessageIdAvailableInLocal({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastMessageIdAvailableInLocal',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QDistinct>
      distinctByLastSyncTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSyncTime');
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QDistinct>
      distinctByTimeSend() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeSend');
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QDistinct> distinctByTo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'to', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QDistinct>
      distinctByToUserName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toUserName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QDistinct>
      distinctByToUserStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toUserStatus');
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QDistinct>
      distinctByUnreadCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unreadCount');
    });
  }

  QueryBuilder<SingleMemberModel, SingleMemberModel, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension SingleMemberModelQueryProperty
    on QueryBuilder<SingleMemberModel, SingleMemberModel, QQueryProperty> {
  QueryBuilder<SingleMemberModel, int, QQueryOperations> boxIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boxId');
    });
  }

  QueryBuilder<SingleMemberModel, ComposedId?, QQueryOperations>
      composedIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'composedId');
    });
  }

  QueryBuilder<SingleMemberModel, String?, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<SingleMemberModel, int?, QQueryOperations>
      contentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentType');
    });
  }

  QueryBuilder<SingleMemberModel, String?, QQueryOperations> fromProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'from');
    });
  }

  QueryBuilder<SingleMemberModel, bool, QQueryOperations>
      isDeletedAccountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeletedAccount');
    });
  }

  QueryBuilder<SingleMemberModel, bool?, QQueryOperations> isGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isGroup');
    });
  }

  QueryBuilder<SingleMemberModel, String?, QQueryOperations> jidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jid');
    });
  }

  QueryBuilder<SingleMemberModel, String?, QQueryOperations>
      lastMessageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMessageId');
    });
  }

  QueryBuilder<SingleMemberModel, String?, QQueryOperations>
      lastMessageIdAvailableInLocalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMessageIdAvailableInLocal');
    });
  }

  QueryBuilder<SingleMemberModel, int?, QQueryOperations>
      lastSyncTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSyncTime');
    });
  }

  QueryBuilder<SingleMemberModel, int?, QQueryOperations> timeSendProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeSend');
    });
  }

  QueryBuilder<SingleMemberModel, String?, QQueryOperations> toProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'to');
    });
  }

  QueryBuilder<SingleMemberModel, String?, QQueryOperations>
      toUserNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toUserName');
    });
  }

  QueryBuilder<SingleMemberModel, int?, QQueryOperations>
      toUserStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toUserStatus');
    });
  }

  QueryBuilder<SingleMemberModel, int?, QQueryOperations>
      unreadCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unreadCount');
    });
  }

  QueryBuilder<SingleMemberModel, String?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ComposedIdSchema = Schema(
  name: r'ComposedId',
  id: -4637760309214235721,
  properties: {
    r'from': PropertySchema(
      id: 0,
      name: r'from',
      type: IsarType.string,
    ),
    r'hashCode': PropertySchema(
      id: 1,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'to': PropertySchema(
      id: 2,
      name: r'to',
      type: IsarType.string,
    )
  },
  estimateSize: _composedIdEstimateSize,
  serialize: _composedIdSerialize,
  deserialize: _composedIdDeserialize,
  deserializeProp: _composedIdDeserializeProp,
);

int _composedIdEstimateSize(
  ComposedId object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.from;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.to;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _composedIdSerialize(
  ComposedId object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.from);
  writer.writeLong(offsets[1], object.hashCode);
  writer.writeString(offsets[2], object.to);
}

ComposedId _composedIdDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ComposedId(
    from: reader.readStringOrNull(offsets[0]),
    to: reader.readStringOrNull(offsets[2]),
  );
  return object;
}

P _composedIdDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ComposedIdQueryFilter
    on QueryBuilder<ComposedId, ComposedId, QFilterCondition> {
  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> fromIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'from',
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> fromIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'from',
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> fromEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> fromGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> fromLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> fromBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'from',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> fromStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> fromEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> fromContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> fromMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'from',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> fromIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'from',
        value: '',
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> fromIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'from',
        value: '',
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition>
      hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> toIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'to',
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> toIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'to',
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> toEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> toGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> toLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> toBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'to',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> toStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> toEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> toContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'to',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> toMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'to',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> toIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'to',
        value: '',
      ));
    });
  }

  QueryBuilder<ComposedId, ComposedId, QAfterFilterCondition> toIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'to',
        value: '',
      ));
    });
  }
}

extension ComposedIdQueryObject
    on QueryBuilder<ComposedId, ComposedId, QFilterCondition> {}
