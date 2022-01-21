import 'package:hive/hive.dart';
import 'package:ioasys_app/external/cache_data_source/enterprise/enterprise_cache_data_source_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'enterprise_cache_data_source_impl_test.mocks.dart';

@GenerateMocks([HiveInterface])
void main() {
  late MockHiveInterface mockHiveInterface;
  late EnterpriseCacheDataSourceImpl enterpriseCacheDataSourceImpl;
  setUpAll(() {
    mockHiveInterface = MockHiveInterface();
    enterpriseCacheDataSourceImpl =
        EnterpriseCacheDataSourceImpl(mockHiveInterface);
  });
  setUp(() {
    reset(mockHiveInterface);
  });
  group('GIVEN a call on getEnterprise', () {
    test(
        'WHEN request is successfully '
        'THEN it should return an EnterpriseModel',
        () async {});
  });
}
