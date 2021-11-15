import 'package:ioasys_app/data/remote/enterprise/model/enterprise/enterprise_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'enterprises_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EnterprisesResponse {
  EnterprisesResponse(
    this.enterprise,
  );

  factory EnterprisesResponse.fromJson(Map<String, dynamic> json) =>
      _$EnterprisesResponseFromJson(json);

  final EnterpriseResponse enterprise;

  Map<String, dynamic> toJson() => _$EnterprisesResponseToJson(this);
}
