import 'package:ioasys_app/data/cache_model/enterprise/model/enterprise_cm.dart';
import 'package:ioasys_app/data/cache_model/enterprise/model/enterprise_type_cm.dart';
import 'package:ioasys_app/domain/enterprise/enterprise_model.dart';

extension EntepriseListModelToEnterpriseListCM on List<EnterpriseModel> {
  List<EnterpriseCM> toEnterpriseListCM() => map((item) => EnterpriseCM(
          item.enterpriseName,
          item.photo,
          item.description,
          item.country,
          EnterpriseTypeCM(item.enterpriseType.enterpriseTypeName),
          item.id,
        ),
      ).toList();
}
