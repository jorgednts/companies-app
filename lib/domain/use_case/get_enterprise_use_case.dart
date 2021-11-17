import 'package:ioasys_app/domain/data_repository/enterprise/enterprise_data_repository.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/use_case/use_case.dart';

class GetEnterpriseUseCase
    extends UseCase<GetEnterpriseUseCaseParams, EnterpriseModel> {
  GetEnterpriseUseCase(
    this.enterpriseDataRepository,
  );

  final EnterpriseDataRepository enterpriseDataRepository;

  @override
  Future<EnterpriseModel> getRawFuture(
          {required GetEnterpriseUseCaseParams params}) =>
      enterpriseDataRepository.getEnterprise(
          params.enterpriseId, params.accessToken, params.uid, params.client);
}

class GetEnterpriseUseCaseParams {
  GetEnterpriseUseCaseParams(
    this.enterpriseId,
    this.accessToken,
    this.uid,
    this.client,
  );

  final int enterpriseId;
  final String accessToken;
  final String uid;
  final String client;
}
