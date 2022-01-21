import 'package:equatable/equatable.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_type_model.dart';

class EnterpriseModel extends Equatable {
  const EnterpriseModel(
    this.enterpriseName,
    this.photo,
    this.description,
    this.country,
    this.enterpriseType,
    this.id,
  );

  final String enterpriseName;
  final String photo;
  final String description;
  final String country;
  final EnterpriseTypeModel enterpriseType;
  final int id;

  @override
  List<Object?> get props => [
        enterpriseName,
        photo,
        description,
        country,
        enterpriseType,
        id,
      ];
}
