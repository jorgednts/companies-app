import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:ioasys_app/data/cache/enterprise/cache_data_source/enterprise_cache_data_source.dart';
import 'package:ioasys_app/data/remote/enterprise/remote_data_source/enterprise_remote_data_source.dart';
import 'package:ioasys_app/data/remote/user/remote_data_source/user_remote_data_source.dart';
import 'package:ioasys_app/data/repository_impl/enterprise/enterprise_repository_impl.dart';
import 'package:ioasys_app/data/repository_impl/user/user_repository_impl.dart';
import 'package:ioasys_app/domain/repository/enterprise/enterprise_repository.dart';
import 'package:ioasys_app/domain/repository/user/user_repository.dart';
import 'package:ioasys_app/domain/use_case/do_login_use_case.dart';
import 'package:ioasys_app/domain/use_case/get_enterprise_list_use_case.dart';
import 'package:ioasys_app/domain/use_case/get_enterprise_use_case.dart';
import 'package:ioasys_app/domain/use_case/validate_email_use_case.dart';
import 'package:ioasys_app/domain/use_case/validate_password_use_case.dart';
import 'package:ioasys_app/external/cache_data_source/enterprise/enterprise_cache_data_source_impl.dart';
import 'package:ioasys_app/external/remote_data_source/enterprise/enterprise_remote_data_source_impl.dart';
import 'package:ioasys_app/external/remote_data_source/user/user_remote_data_source_impl.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: Dio()),
  Provider.value(value: Hive),
  Provider.value(value: ValidateEmailUseCase()),
  Provider.value(value: ValidatePasswordUseCase()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<Dio, EnterpriseRemoteDataSource>(
    update: (_, dio, __) => EnterpriseRemoteDataSourceImpl(dio),
  ),
  ProxyProvider<Dio, UserRemoteDataSource>(
    update: (_, dio, __) => UserRemoteDataSourceImpl(dio),
  ),
  ProxyProvider<HiveInterface, EnterpriseCacheDataSource>(
    update: (_, hive, __) => EnterpriseCacheDataSourceImpl(hive),
  ),
  ProxyProvider2<EnterpriseRemoteDataSource, EnterpriseCacheDataSource,
      EnterpriseRepository>(
    update: (_, enterpriseRemoteDataSource, enterpriseCacheDataSource, __) =>
        EnterpriseRepositoryImpl(
            enterpriseRemoteDataSource, enterpriseCacheDataSource),
  ),
  ProxyProvider<UserRemoteDataSource, UserRepository>(
    update: (_, userRemoteDataSource, __) =>
        UserRepositoryImpl(userRemoteDataSource),
  ),
  ProxyProvider<UserRepository, DoLoginUseCase>(
    update: (_, userRepository, __) => DoLoginUseCase(userRepository),
  ),
  ProxyProvider<EnterpriseRepository, GetEnterpriseListUseCase>(
    update: (_, enterpriseRepository, __) =>
        GetEnterpriseListUseCase(enterpriseRepository),
  ),
  ProxyProvider<EnterpriseRepository, GetEnterpriseUseCase>(
    update: (_, enterpriseRepository, __) =>
        GetEnterpriseUseCase(enterpriseRepository),
  ),
];
