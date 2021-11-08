// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enterprise_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnterpriseListResponse _$EnterpriseListResponseFromJson(
    Map<String, dynamic> json) {
  return EnterpriseListResponse(
    (json['enterprises'] as List<dynamic>)
        .map((e) => EnterpriseResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$EnterpriseListResponseToJson(
        EnterpriseListResponse instance) =>
    <String, dynamic>{
      'enterprises': instance.enterprises,
    };
