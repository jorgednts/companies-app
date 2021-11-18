import 'package:hive/hive.dart';
import 'package:ioasys_app/constants/constants_cache_data_source.dart';
import 'package:ioasys_app/data/cache/enterprise/model/enterprise_cm.dart';
import 'package:ioasys_app/domain/exception/empty_enterprise_exception.dart';

class EnterpriseCacheDataSourceImpl {
  Future<EnterpriseCM> getEnterprise(int id) async {
    final enterpriseCM = await Hive.openBox<EnterpriseCM>(
            ConstantsCacheDataSource.keyEnterpriseCM)
        .then(
      (box) => box.get(id),
    );
    if (enterpriseCM != null) {
      return enterpriseCM;
    } else {
      throw EmptyEnterpriseException();
    }
  }

  Future<void> saveEnterprise(EnterpriseCM enterpriseCM) async {
    final box = await Hive.openBox<EnterpriseCM>(
        ConstantsCacheDataSource.keyEnterpriseCM);
    await box.put(enterpriseCM.id, enterpriseCM);
  }
}
