import 'package:ioasys_app/data/cache_model/enterprise/model/enterprise_cm.dart';
import 'package:ioasys_app/domain/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/enterprise/enterprise_type_model.dart';

extension EnterpriseCMToEnterpriseModel on EnterpriseCM {
  EnterpriseModel toEnterpriseModel() => EnterpriseModel(
        enterpriseName,
        photo,
        description,
        country,
        EnterpriseTypeModel(enterpriseType.enterpriseTypeName),
        id,
      );
}
