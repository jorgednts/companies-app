import 'package:hive/hive.dart';
import 'package:ioasys_app/data/cache_model/enterprise/model/enterprise_cm.dart';

class EnterpriseCacheDataSource {
  Future<List<EnterpriseCM>> getEnterpriseList(String enterpriseName) async {
    final box = await Hive.openBox('enterpriseList');
    final enterpriseListCM = List<EnterpriseCM>.from(box.get(1));
    return enterpriseListCM
        .where((element) => element.enterpriseName.contains(enterpriseName))
        .toList();
  }

  Future<void> saveEnterpriseList(List<EnterpriseCM> enterpriseListCM) async {
    final box = await Hive.openBox('enterpriseList');
    enterpriseListCM.forEach((enterpriseCM) async {
      await box.put(enterpriseCM.id, enterpriseCM);
    });
  }
}
