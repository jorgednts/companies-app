import 'package:json_annotation/json_annotation.dart';
part 'user_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserRequest {
  UserRequest(this.email, this.password);

  factory UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);

  final String email;
  final String password;

  Map<String, dynamic> toJson() => _$UserRequestToJson(this);

}
