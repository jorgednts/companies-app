import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';

mixin EnterpriseDataRepository {
  Future<List<EnterpriseModel>> getEnterpriseList(
      String enterpriseName, String accessToken, String uid, String client);

  Future<EnterpriseModel> getEnterprise(
      int id, String accessToken, String uid, String client);
}
