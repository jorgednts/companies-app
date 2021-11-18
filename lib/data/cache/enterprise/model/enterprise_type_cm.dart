import 'package:hive/hive.dart';
part 'enterprise_type_cm.g.dart';

@HiveType(typeId: 1)
class EnterpriseTypeCM {
  EnterpriseTypeCM(
      this.enterpriseTypeName,
      );

  @HiveField(0)
  final String enterpriseTypeName;
}
