import 'package:ioasys_app/domains/enterprise/enterprise_type_response.dart';

class EnterpriseResponse {
  final String? _enterprise_name;
  final String? _photo;
  final String? _description;
  final String? _country;
  final EnterpriseTypeResponse? _enterpriseTypeResponse;

  EnterpriseResponse(this._enterprise_name, this._photo, this._description,
      this._country, this._enterpriseTypeResponse);

  EnterpriseTypeResponse? get enterpriseTypeResponse => _enterpriseTypeResponse;

  String? get country => _country;

  String? get description => _description;

  String? get photo => _photo;

  String? get enterprise_name => _enterprise_name;
}