import 'package:ioasys_app/data/repository/enterprise_repository/enterprise_data_repository.dart';

class MainBloc {
  MainBloc(
    this._enterpriseDataRepository,
  );

  final EnterpriseDataRepository _enterpriseDataRepository;

  void dispose(){

  }
}
