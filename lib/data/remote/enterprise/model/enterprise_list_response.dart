
import 'package:ioasys_app/data/remote/enterprise/model/enterprise_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'enterprise_list_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EnterpriseListResponse {
  EnterpriseListResponse(this.enterprises);

  factory EnterpriseListResponse.fromJson(Map<String, dynamic> json) =>
      _$EnterpriseListResponseFromJson(json);

  final List<EnterpriseResponse>? enterprises;

  Map<String, dynamic> toJson() => _$EnterpriseListResponseToJson(this);

}
