import 'package:hive/hive.dart';
import 'package:ioasys_app/constants/constants_cache_data_source.dart';
import 'package:ioasys_app/data/cache/enterprise/cache_data_source/enterprise_cache_data_source.dart';
import 'package:ioasys_app/data/cache/enterprise/model/enterprise_cm.dart';
import 'package:ioasys_app/domain/exception/empty_enterprise_exception.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';
import 'package:ioasys_app/data/mapper/cache_to_model.dart';
import 'package:ioasys_app/data/mapper/model_to_cache.dart';

class EnterpriseCacheDataSourceImpl implements EnterpriseCacheDataSource {
  @override
  Future<EnterpriseModel> getEnterprise(int id) async {
    final enterpriseCM = await Hive.openBox<EnterpriseCM>(
            ConstantsCacheDataSource.keyEnterpriseCM)
        .then(
      (box) => box.get(id),
    );
    if (enterpriseCM != null) {
      return enterpriseCM.toEnterpriseModel();
    } else {
      throw EmptyEnterpriseException();
    }
  }

  @override
  Future<void> saveEnterprise(EnterpriseModel enterpriseModel) async {
    final enterpriseCM = enterpriseModel.toEnterpriseCM();
    final box = await Hive.openBox<EnterpriseCM>(
        ConstantsCacheDataSource.keyEnterpriseCM);
    await box.put(enterpriseCM.id, enterpriseCM);
  }
}
