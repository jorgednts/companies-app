import 'package:hive/hive.dart';
import 'package:ioasys_app/domain/enterprise/enterprise_type_model.dart';
part 'enterprise_cm.g.dart';

@HiveType(typeId: 0)
class EnterpriseCM {
  EnterpriseCM(
    this.enterpriseName,
    this.photo,
    this.description,
    this.country,
    this.enterpriseType,
  );

  @HiveField(0)
  final String enterpriseName;
  @HiveField(1)
  final String photo;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String country;
  @HiveField(4)
  final EnterpriseTypeModel enterpriseType;
}
