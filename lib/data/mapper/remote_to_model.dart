import 'package:ioasys_app/data/remote/enterprise/model/enterprise/enterprise_list_response.dart';
import 'package:ioasys_app/domain/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/enterprise/enterprise_type_model.dart';

extension EntepriseListResponseToEnterpriseListModel on EnterpriseListResponse {
  List<EnterpriseModel> toEnterpriseListModel() => enterprises
      .map(
        (item) => EnterpriseModel(
          item.enterpriseName ?? '-',
          item.photo ?? '-',
          item.description ?? '-',
          item.country ?? '-',
          EnterpriseTypeModel(
              item.enterpriseTypeResponse?.enterpriseTypeName ?? '-'),
          item.id ?? -1,
        ),
      )
      .toList();
}
