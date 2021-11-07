import 'package:ioasys_app/data/remote/user/model/user/user_request.dart';
import 'package:ioasys_app/domain/user/user_model.dart';

extension UserModelToUserRequestExtensions on UserModel {
  UserRequest toUserRequest() => UserRequest(
        email,
        password,
      );
}