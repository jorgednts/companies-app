import 'package:hive/hive.dart';
import 'package:ioasys_app/view/main_view/widgets/empty_enterprise_list.dart';

class EnterpriseCacheDataSource {
  Future<List<EntepriseCM>> getEnterpriseList async {
    final box = await Hive.openBox('enterpriseList');
    return List<EnterpriseCM>.from(box.get(1));
}
Future<void> saveEnterpriseList(List<EnterpriseCM> enterpriseList) async {
  final box = await Hive.openBox('enterpriseList');

}
}