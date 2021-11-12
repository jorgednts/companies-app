import 'package:hive/hive.dart';
import 'package:ioasys_app/constants/constants_cache_data_source.dart';
import 'package:ioasys_app/data/cache_model/enterprise/model/enterprise_cm.dart';

class EnterpriseCacheDataSource {
  Future<EnterpriseCM?> getEnterprise(int id) async {
    final enterpriseCM = await Hive.openBox<EnterpriseCM>(
            ConstantsCacheDataSource.keyEnterpriseCM)
        .then(
      (value) => value.get(id),
    );
    return enterpriseCM;
  }

  Future<void> saveEnterprise(EnterpriseCM enterpriseCM) async {
    final box = await Hive.openBox(ConstantsCacheDataSource.keyEnterpriseCM);
    await box.put(enterpriseCM.id, enterpriseCM);
  }
}
