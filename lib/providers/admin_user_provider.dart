import 'package:flutter/foundation.dart';
import 'package:hms_models/models/admin_user/admin_user_model.dart';

class AdminUserProvider extends ChangeNotifier {
  //region Logged In Admin User Model
  AdminUserModel? _adminUserModel;
  String _adminUserId = "";

  AdminUserModel? getAdminUserModel() {
    if(_adminUserModel != null) {
      return AdminUserModel.fromMap(_adminUserModel!.toMap());
    }
    else {
      return null;
    }
  }

  void setAdminUserModel(AdminUserModel? adminUserModel, {bool isNotify = true}) {
    if(adminUserModel != null) {
      if(_adminUserModel != null) {
        _adminUserModel!.updateFromMap(adminUserModel.toMap());
      }
      else {
        _adminUserModel = AdminUserModel.fromMap(adminUserModel.toMap());
      }
    }
    else {
      _adminUserModel = null;
    }
    if(isNotify) {
      notifyListeners();
    }
  }
  //endregion

  //region Logged In Admin User Id
  String _adminUserId = "";

  String get adminUserId => _adminUserId;

  void setAdminUserId(String adminUserId, {bool isNotify = true}) {
    _adminUserId = adminUserId;
    if(isNotify) {
      notifyListeners();
    }
  }
  //endregion
}