import 'package:ioasys_app/domain/enterprise/enterprise_model.dart';

mixin EnterpriseDataRepository {
  Future<List<EnterpriseModel>> getEnterpriseList(
      String enterpriseName, String accessToken, String uid, String client);
}
