

import 'package:ioasys_app/data/remote/enterprise/model/enterprise_type_response.dart';

class EnterpriseResponse {
  String? _enterpriseName;
  String? _photo;
  String? _description;
  String? _country;
  EnterpriseTypeResponse? _enterpriseTypeResponse;

  EnterpriseResponse(this._enterpriseName, this._photo, this._description,
      this._country, this._enterpriseTypeResponse);

  EnterpriseTypeResponse? get enterpriseTypeResponse => _enterpriseTypeResponse;

  String? get country => _country;

  String? get description => _description;

  String? get photo => _photo;

  String? get enterpriseName => _enterpriseName;
}