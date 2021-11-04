import 'package:ioasys_app/domain/enterprise/enterprise_type_model.dart';

class EnterpriseModel {
  EnterpriseModel(
    this.enterpriseName,
    this.photo,
    this.description,
    this.country,
    this.enterpriseType,
  );

  final String enterpriseName;
  final String photo;
  final String description;
  final String country;
  final EnterpriseTypeModel enterpriseType;
}
