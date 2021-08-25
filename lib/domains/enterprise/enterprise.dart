import 'package:ioasys_app/domains/enterprise/enterprise_type.dart';

class Enterprise {
  final String _enterprise_name;
  final String _photo;
  final String _description;
  final String _country;
  final EnterpriseType _enterprise_type;

  Enterprise(this._enterprise_name, this._photo, this._description,
      this._country, this._enterprise_type);

  EnterpriseType get enterprise_type => _enterprise_type;

  String get country => _country;

  String get description => _description;

  String get photo => _photo;

  String get enterprise_name => _enterprise_name;
}