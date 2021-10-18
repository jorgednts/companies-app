

import 'package:ioasys_app/data/remote/enterprise/model/enterprise_response.dart';

class EnterpriseListResponse {
  List<EnterpriseResponse>? _enterprises;

  EnterpriseListResponse(this._enterprises);

  List<EnterpriseResponse>? get enterprises => _enterprises;

}
