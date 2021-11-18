import 'package:ioasys_app/data/cache/enterprise/cache_data_source/enterprise_cache_data_source.dart';
import 'package:ioasys_app/data/remote/enterprise/remote_data_source/enterprise_remote_data_source.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/repository/enterprise/enterprise_repository.dart';

class EnterpriseRepositoryImpl implements EnterpriseRepository {
  EnterpriseRepositoryImpl(
    this.enterpriseRemoteDataSource,
    this.enterpriseCacheDataSource,
  );

  final EnterpriseRemoteDataSource enterpriseRemoteDataSource;
  final EnterpriseCacheDataSource enterpriseCacheDataSource;

  @override
  Future<List<EnterpriseModel>> getEnterpriseList(String enterpriseName,
      String accessToken, String uid, String client) async {
    final enterpriseListModel = await enterpriseRemoteDataSource
        .getEnterpriseList(enterpriseName, accessToken, uid, client);
    return enterpriseListModel;
  }

  @override
  Future<EnterpriseModel> getEnterprise(
      int id, String accessToken, String uid, String client) async {
    try {
      final enterpriseModel = await enterpriseRemoteDataSource.getEnterprise(
          id, accessToken, uid, client);
      await enterpriseCacheDataSource.saveEnterprise(enterpriseModel);
      return enterpriseCacheDataSource.getEnterprise(id);
    } on Exception {
      return enterpriseCacheDataSource.getEnterprise(id);
    }
  }
}
