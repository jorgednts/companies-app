import 'package:json_annotation/json_annotation.dart';
part 'user_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserRequest {
  final String email;
  final String password;

  UserRequest(this.email, this.password);

  factory UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);

  String get passwordUserRequest => password;

  String get emailUserRequest => email;

  Map<String, dynamic> toJson() => _$UserRequestToJson(this);

}
