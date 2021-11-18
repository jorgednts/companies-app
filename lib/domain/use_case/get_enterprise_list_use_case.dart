import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/repository/enterprise/enterprise_repository.dart';
import 'package:ioasys_app/domain/use_case/use_case.dart';

class GetEnterpriseListUseCase
    extends UseCase<GetEnterpriseListUseCaseParams, List<EnterpriseModel>> {
  GetEnterpriseListUseCase(
    this.enterpriseRepository,
  );

  final EnterpriseRepository enterpriseRepository;

  @override
  Future<List<EnterpriseModel>> getRawFuture(
          {required GetEnterpriseListUseCaseParams params}) =>
      enterpriseRepository.getEnterpriseList(
          params.enterpriseName, params.accessToken, params.uid, params.client);
}

class GetEnterpriseListUseCaseParams {
  GetEnterpriseListUseCaseParams(
    this.enterpriseName,
    this.accessToken,
    this.uid,
    this.client,
  );

  final String enterpriseName;
  final String accessToken;
  final String uid;
  final String client;
}
