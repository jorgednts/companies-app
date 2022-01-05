import 'package:equatable/equatable.dart';

class UserTokens extends Equatable {
  const UserTokens(
    this.accessToken,
    this.client,
    this.uid,
  );

  final String accessToken;
  final String client;
  final String uid;

  @override
  List<Object?> get props => [
        accessToken,
        client,
        uid,
      ];
}
