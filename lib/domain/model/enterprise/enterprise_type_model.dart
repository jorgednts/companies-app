import 'package:equatable/equatable.dart';

class EnterpriseTypeModel extends Equatable {
  const EnterpriseTypeModel(
    this.enterpriseTypeName,
  );

  final String enterpriseTypeName;

  @override
  List<Object?> get props => [
        enterpriseTypeName,
      ];
}
