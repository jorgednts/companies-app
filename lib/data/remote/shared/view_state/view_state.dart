import 'package:ioasys_app/domain/user/user_tokens.dart';

abstract class ViewState {}

class LoadingState implements ViewState {}

class GenericErrorState implements ViewState {}

class UnauthorizedErrorState implements ViewState{}

class NetworkErrorState implements ViewState{}

class SuccessState implements ViewState {
  SuccessState(this.userTokens);
  final UserTokens userTokens;
}
