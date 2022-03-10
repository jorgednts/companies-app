// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enterprises_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnterprisesResponse _$EnterprisesResponseFromJson(Map<String, dynamic> json) =>
    EnterprisesResponse(
      EnterpriseResponse.fromJson(json['enterprise'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EnterprisesResponseToJson(
        EnterprisesResponse instance) =>
    <String, dynamic>{
      'enterprise': instance.enterprise,
    };
