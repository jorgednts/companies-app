import 'package:dio/dio.dart';
import 'package:ioasys_app/domain/repository/enterprise/enterprise_repository.dart';
import 'package:ioasys_app/domain/repository/user/user_repository.dart';
import 'package:ioasys_app/external/cache/enterprise/enterprise_cache_data_source_impl.dart';
import 'package:ioasys_app/external/remote/enterprise/enterprise_remote_data_source_impl.dart';
import 'package:ioasys_app/external/remote/user/user_remote_data_source_impl.dart';
import 'package:ioasys_app/data/repository/enterprise/enterprise_repository_impl.dart';
import 'package:ioasys_app/data/repository/user/user_repository_impl.dart';
import 'package:ioasys_app/domain/use_case/do_login_use_case.dart';
import 'package:ioasys_app/domain/use_case/get_enterprise_list_use_case.dart';
import 'package:ioasys_app/domain/use_case/get_enterprise_use_case.dart';
import 'package:ioasys_app/domain/use_case/validate_email_use_case.dart';
import 'package:ioasys_app/domain/use_case/validate_password_use_case.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: Dio()),
  Provider.value(value: EnterpriseCacheDataSourceImpl()),
  Provider.value(value: ValidateEmailUseCase()),
  Provider.value(value: ValidatePasswordUseCase())
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<Dio, EnterpriseRemoteDataSourceImpl>(
    update: (_, dio, __) => EnterpriseRemoteDataSourceImpl(dio),
  ),
  ProxyProvider<Dio, UserRemoteDataSourceImpl>(
    update: (_, dio, __) => UserRemoteDataSourceImpl(dio),
  ),
  ProxyProvider2<EnterpriseRemoteDataSourceImpl, EnterpriseCacheDataSourceImpl,
      EnterpriseRepository>(
    update: (_, enterpriseRemoteDataSource, enterpriseCacheDataSource, __) =>
        EnterpriseRepositoryImpl(
            enterpriseRemoteDataSource, enterpriseCacheDataSource),
  ),
  ProxyProvider<UserRemoteDataSourceImpl, UserRepository>(
    update: (_, userRemoteDataSource, __) =>
        UserRepositoryImpl(userRemoteDataSource),
  ),
  ProxyProvider<UserRepository, DoLoginUseCase>(
    update: (_, userDataRepository, __) => DoLoginUseCase(userDataRepository),
  ),
  ProxyProvider<EnterpriseRepository, GetEnterpriseListUseCase>(
    update: (_, enterpriseDataRepository, __) =>
        GetEnterpriseListUseCase(enterpriseDataRepository),
  ),
  ProxyProvider<EnterpriseRepository, GetEnterpriseUseCase>(
    update: (_, enterpriseDataRepository, __) =>
        GetEnterpriseUseCase(enterpriseDataRepository),
  ),
];
