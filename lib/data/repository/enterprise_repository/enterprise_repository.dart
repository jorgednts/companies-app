import 'package:ioasys_app/data/remote/enterprise/remote_data_source/enterprise_remote_data_source.dart';
import 'package:ioasys_app/data/repository/enterprise_repository/enterprise_data_repository.dart';
import 'package:ioasys_app/domain/enterprise/enterprise_model.dart';

class EnterpriseRepository implements EnterpriseDataRepository {
  EnterpriseRepository(
    this._enterpriseRemoteDataSource,
  );

  final EnterpriseRemoteDataSource _enterpriseRemoteDataSource;

  @override
  Future<List<EnterpriseModel>> getEnterpriseList(String enterpriseName,
          String accessToken, String uid, String client) async =>
      _enterpriseRemoteDataSource.getEnterpriseList(
          enterpriseName, accessToken, uid, client);
}
