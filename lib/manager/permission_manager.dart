import 'package:deneme1/abstract/permission_abstract.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';

class PermissionManager implements IPermission{
  final PermissionHandlerPlatform _permissionHandler =
      PermissionHandlerPlatform.instance;
  @override
  Future<bool> handlePermission(Permission permission) async {
    var status = await permission.status;
    if ((status.isGranted)) {
      debugPrint("izin önceden verilmiş");
      return true;
    } else if (status.isDenied) {
      final requestResult =
          await _permissionHandler.requestPermissions([permission]);
      debugPrint("denided kısmına girdi");
      status = await permission.status;
      if (status.isDenied) {
        if (requestResult.toString().contains("permanentlyDenied")) {
          openAppSettings();
        } else {
          return false;
        }
      } else {
        return true;
      }
    }
    return false;
  }
}