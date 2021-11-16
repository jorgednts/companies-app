import 'package:ioasys_app/constants/constants_url_api.dart';
import 'package:ioasys_app/data/remote/enterprise/model/enterprise/enterprise_list_response.dart';
import 'package:ioasys_app/data/remote/enterprise/model/enterprise/enterprises_response.dart';
import 'package:ioasys_app/domain/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/enterprise/enterprise_type_model.dart';

extension EntepriseListResponseToEnterpriseListModel on EnterpriseListResponse {
  List<EnterpriseModel> toEnterpriseListModel() => enterprises
      .map(
        (item) => EnterpriseModel(
          item.enterpriseName ?? '-',
          item.photo == null ? '-' : '${ConstantsUrlApi.baseUrl}${item.photo}',
          item.description ?? '-',
          item.country ?? '-',
          EnterpriseTypeModel(item.enterpriseType?.enterpriseTypeName ?? '-'),
          item.id ?? -1,
        ),
      )
      .toList();
}

extension EnterpriseResponseToEnterpriseModel on EnterprisesResponse {
  EnterpriseModel toEnterpriseModel() => EnterpriseModel(
        enterprise.enterpriseName ?? '-',
        enterprise.photo == null
            ? '-'
            : '${ConstantsUrlApi.baseUrl}${enterprise.photo}',
        enterprise.description ?? '-',
        enterprise.country ?? '-',
        EnterpriseTypeModel(
            enterprise.enterpriseType?.enterpriseTypeName ?? '-'),
        enterprise.id ?? -1,
      );
}
