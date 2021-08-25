import 'package:ioasys_app/domains/enterprise/enterprise_response.dart';

class EnterpriseListResponse {
  List<EnterpriseResponse>? _enterprises;

  EnterpriseListResponse(this._enterprises);

  List<EnterpriseResponse>? get enterprises => _enterprises;

}
