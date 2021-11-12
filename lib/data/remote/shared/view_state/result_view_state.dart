import 'package:ioasys_app/domain/enterprise/enterprise_model.dart';

abstract class ResultViewState {}

class LoadingState implements ResultViewState {}

class GenericErrorState implements ResultViewState {}

class NetworkErrorState implements ResultViewState {}

class SuccessState implements ResultViewState {
  SuccessState(
    this.enterprise,
  );

  final EnterpriseModel enterprise;
}
