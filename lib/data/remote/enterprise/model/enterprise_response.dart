import 'package:ioasys_app/data/remote/enterprise/model/enterprise_type_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'enterprise_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EnterpriseResponse {
  EnterpriseResponse(this.enterpriseName, this.photo, this.description,
      this.country, this.enterpriseTypeResponse);

  factory EnterpriseResponse.fromJson(Map<String, dynamic> json) =>
      _$EnterpriseResponseFromJson(json);

  final String? enterpriseName;
  final String? photo;
  final String? description;
  final String? country;
  final EnterpriseTypeResponse? enterpriseTypeResponse;

  Map<String, dynamic> toJson() => _$EnterpriseResponseToJson(this);

}