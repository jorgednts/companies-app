import 'package:hive/hive.dart';
import 'package:ioasys_app/data/cache_model/enterprise/model/enterprise_type_cm.dart';

part 'enterprise_cm.g.dart';

@HiveType(typeId: 0)
class EnterpriseCM {
  EnterpriseCM(
    this.enterpriseName,
    this.photo,
    this.description,
    this.country,
    this.enterpriseType,
    this.id,
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
  final EnterpriseTypeCM enterpriseType;
  @HiveField(5)
  final int id;
}
