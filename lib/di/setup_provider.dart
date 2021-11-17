import 'package:dio/dio.dart';
import 'package:ioasys_app/data/cache_model/enterprise/cache_data_source/enterprise_cache_data_source.dart';
import 'package:ioasys_app/data/remote/enterprise/remote_data_source/enterprise_remote_data_source.dart';
import 'package:ioasys_app/data/remote/user/remote_data_source/user_remote_data_source.dart';
import 'package:ioasys_app/data/repository/enterprise/enterprise_repository.dart';
import 'package:ioasys_app/data/repository/user/user_repository.dart';
import 'package:ioasys_app/domain/data_repository/enterprise/enterprise_data_repository.dart';
import 'package:ioasys_app/domain/data_repository/user/user_data_repository.dart';
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
  Provider.value(value: EnterpriseCacheDataSource()),
  Provider.value(value: ValidateEmailUseCase()),
  Provider.value(value: ValidatePasswordUseCase())
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
  ProxyProvider<UserDataRepository, DoLoginUseCase>(
    update: (_, userDataRepository, __) => DoLoginUseCase(userDataRepository),
  ),
  ProxyProvider<EnterpriseDataRepository, GetEnterpriseListUseCase>(
    update: (_, enterpriseDataRepository, __) =>
        GetEnterpriseListUseCase(enterpriseDataRepository),
  ),
  ProxyProvider<EnterpriseDataRepository, GetEnterpriseUseCase>(
    update: (_, enterpriseDataRepository, __) =>
        GetEnterpriseUseCase(enterpriseDataRepository),
  ),
];
