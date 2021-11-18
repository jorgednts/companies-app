import 'package:ioasys_app/data/cache/enterprise/model/enterprise_cm.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_type_model.dart';

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
