import 'package:ioasys_app/domain/enterprise/enterprise_model.dart';

abstract class MainViewState {}

class LoadingState implements MainViewState{}

class InitialState implements MainViewState{}

class NoResult implements MainViewState {}

class GenericErrorState implements MainViewState {}

class NetworkErrorState implements MainViewState {}

class SuccessState implements MainViewState {
  SuccessState(
    this.enterprises,
  );

  final List<EnterpriseModel> enterprises;
}
