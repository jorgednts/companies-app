
import 'package:ioasys_app/domain/enterprise/enterprise_type_model.dart';

class EnterpriseModel {
  String _enterpriseName;
  String _photo;
  String _description;
  String _country;
  EnterpriseTypeModel _enterpriseType;

  EnterpriseModel(this._enterpriseName, this._photo, this._description,
      this._country, this._enterpriseType);

  EnterpriseTypeModel get enterpriseType => _enterpriseType;

  String get country => _country;

  String get description => _description;

  String get photo => _photo;

  String get enterpriseName => _enterpriseName;
}