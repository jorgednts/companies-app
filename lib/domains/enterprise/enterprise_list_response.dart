import 'package:ioasys_app/domains/enterprise/enterprise_response.dart';

class EnterpriseListResponse{
  late List<EnterpriseResponse>? _enterprises;

  EnterpriseListResponse(this._enterprises);

  List<EnterpriseResponse>? get enterprises => _enterprises;
}