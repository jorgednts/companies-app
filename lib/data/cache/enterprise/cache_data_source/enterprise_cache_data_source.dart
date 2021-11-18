import 'package:ioasys_app/data/cache/enterprise/model/enterprise_cm.dart';

abstract class EnterpriseCacheDataSource {
  Future<EnterpriseCM> getEnterprise(int id);
  Future<void> saveEnterprise(EnterpriseCM enterpriseCM);
}
