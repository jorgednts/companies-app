import 'package:ioasys_app/data/remote/enterprise/model/enterprise/enterprise_list_response.dart';
import 'package:ioasys_app/data/remote/enterprise/model/enterprise/enterprises_response.dart';

abstract class EnterpriseRemoteDataSource {
  Future<EnterpriseListResponse> getEnterpriseList(
      String enterpriseName, String accessToken, String uid, String client);
  Future<EnterprisesResponse> getEnterprise(
      int id, String accessToken, String uid, String client);
}
