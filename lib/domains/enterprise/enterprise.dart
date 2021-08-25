import 'package:ioasys_app/domains/enterprise/enterprise_type.dart';

class Enterprise {
  String _enterpriseName;
  String _photo;
  String _description;
  String _country;
  EnterpriseType _enterpriseType;

  Enterprise(this._enterpriseName, this._photo, this._description,
      this._country, this._enterpriseType);

  EnterpriseType get enterpriseType => _enterpriseType;

  String get country => _country;

  String get description => _description;

  String get photo => _photo;

  String get enterpriseName => _enterpriseName;
}