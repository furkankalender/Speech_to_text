import 'package:permission_handler/permission_handler.dart';

abstract class IPermission {
  Future<bool> handlePermission(Permission permission);
}
