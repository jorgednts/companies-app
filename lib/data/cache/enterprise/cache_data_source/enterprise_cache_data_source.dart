import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';

abstract class EnterpriseCacheDataSource {
  Future<EnterpriseModel> getEnterprise(int id);
  Future<void> saveEnterprise(EnterpriseModel enterpriseModel);
}
