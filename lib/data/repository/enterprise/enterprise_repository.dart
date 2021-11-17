import 'package:ioasys_app/data/cache_model/enterprise/cache_data_source/enterprise_cache_data_source.dart';
import 'package:ioasys_app/data/mapper/cache_to_model.dart';
import 'package:ioasys_app/data/mapper/model_to_cache.dart';
import 'package:ioasys_app/data/mapper/remote_to_model.dart';
import 'package:ioasys_app/data/remote/enterprise/remote_data_source/enterprise_remote_data_source.dart';
import 'package:ioasys_app/domain/data_repository/enterprise/enterprise_data_repository.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';

class EnterpriseRepository implements EnterpriseDataRepository {
  EnterpriseRepository(
    this.enterpriseRemoteDataSource,
    this.enterpriseCacheDataSource,
  );

  final EnterpriseRemoteDataSource enterpriseRemoteDataSource;
  final EnterpriseCacheDataSource enterpriseCacheDataSource;

  @override
  Future<List<EnterpriseModel>> getEnterpriseList(String enterpriseName,
      String accessToken, String uid, String client) async {
    final enterpriseListResponse = await enterpriseRemoteDataSource
        .getEnterpriseList(enterpriseName, accessToken, uid, client);
    return enterpriseListResponse.toEnterpriseListModel();
  }

  @override
  Future<EnterpriseModel> getEnterprise(
      int id, String accessToken, String uid, String client) async {
    try {
      final enterpriseResponse = await enterpriseRemoteDataSource.getEnterprise(
          id, accessToken, uid, client);
      final enterpriseModel = enterpriseResponse.toEnterpriseModel();
      await enterpriseCacheDataSource
          .saveEnterprise(enterpriseModel.toEnterpriseCM());
      final enterpriseCM = await enterpriseCacheDataSource.getEnterprise(id);
      return enterpriseCM.toEnterpriseModel();
    } on Exception {
      final enterpriseCM = await enterpriseCacheDataSource.getEnterprise(id);
      return enterpriseCM.toEnterpriseModel();
    }
  }
}
