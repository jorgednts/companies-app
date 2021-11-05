// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enterprise_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnterpriseResponse _$EnterpriseResponseFromJson(Map<String, dynamic> json) {
  return EnterpriseResponse(
    json['enterprise_name'] as String?,
    json['photo'] as String?,
    json['description'] as String?,
    json['country'] as String?,
    json['enterprise_type_response'] == null
        ? null
        : EnterpriseTypeResponse.fromJson(
            json['enterprise_type_response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EnterpriseResponseToJson(EnterpriseResponse instance) =>
    <String, dynamic>{
      'enterprise_name': instance.enterpriseName,
      'photo': instance.photo,
      'description': instance.description,
      'country': instance.country,
      'enterprise_type_response': instance.enterpriseTypeResponse,
    };
