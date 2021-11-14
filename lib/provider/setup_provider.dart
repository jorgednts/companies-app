import 'package:dio/dio.dart';
import 'package:ioasys_app/data/cache_model/enterprise/cache_data_source/enterprise_cache_data_source.dart';
import 'package:ioasys_app/data/remote/enterprise/remote_data_source/enterprise_remote_data_source.dart';
import 'package:ioasys_app/data/remote/user/remote_data_source/user_remote_data_source.dart';
import 'package:ioasys_app/data/repository/enterprise_repository/enterprise_data_repository.dart';
import 'package:ioasys_app/data/repository/enterprise_repository/enterprise_repository.dart';
import 'package:ioasys_app/data/repository/user_repository/user_data_repository.dart';
import 'package:ioasys_app/data/repository/user_repository/user_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: Dio()),
  Provider.value(value: EnterpriseCacheDataSource())
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<Dio, EnterpriseRemoteDataSource>(
    update: (_, dio, __) => EnterpriseRemoteDataSource(dio),
  ),
  ProxyProvider<Dio, UserRemoteDataSource>(
    update: (_, dio, __) => UserRemoteDataSource(dio),
  ),
  ProxyProvider2<EnterpriseRemoteDataSource, EnterpriseCacheDataSource,
      EnterpriseDataRepository>(
    update: (_, enterpriseRemoteDataSource, enterpriseCacheDataSource, __) =>
        EnterpriseRepository(
            enterpriseRemoteDataSource, enterpriseCacheDataSource),
  ),
  ProxyProvider<UserRemoteDataSource, UserDataRepository>(
    update: (_, userRemoteDataSource, __) =>
        UserRepository(userRemoteDataSource),
  ),
];
