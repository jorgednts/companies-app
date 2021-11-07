import 'package:json_annotation/json_annotation.dart';

part 'enterprise_type_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EnterpriseTypeResponse {
  EnterpriseTypeResponse(
    this.enterpriseTypeName,
  );

  factory EnterpriseTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$EnterpriseTypeResponseFromJson(json);

  final String? enterpriseTypeName;

  Map<String, dynamic> toJson() => _$EnterpriseTypeResponseToJson(this);
}
