import 'package:ioasys_app/data/remote/enterprise/model/enterprise/enterprise_list_response.dart';
import 'package:ioasys_app/domain/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/enterprise/enterprise_type_model.dart';
import 'package:ioasys_app/extensions/string_extensions.dart';

extension EntepriseListResponseToEnterpriseListModel on EnterpriseListResponse {
  // List<EnterpriseModel> toEnterpriseListModel() => enterprises
  //     .map((item) => EnterpriseModel(
  //         item.enterpriseName.isBlank() ? '-' : item.enterpriseName,
  //         item.photo.isBlank() ? '-' : item.photo,
  //         item.description.isBlank() ? '-' : item.description,
  //         item.country.isBlank() ? '-' : item.country,
  //         EnterpriseTypeModel(
  //             item.enterpriseTypeResponse?.enterpriseTypeName.isBlank()
  //                 ? '-'
  //                 : item.enterpriseTypeResponse.enterpriseTypeName)))
  //     .toList();
}
