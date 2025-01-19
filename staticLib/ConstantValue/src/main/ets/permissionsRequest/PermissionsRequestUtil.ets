import PermissionRequest from "./PermissionsRequest";
import { Permissions } from "@kit.AbilityKit";

export default class PermissionsRequestUtil {
  private static readonly permissionRequest: PermissionRequest = new PermissionRequest();

  static requestPermissions(permissions: Permissions): boolean {
    return PermissionsRequestUtil.permissionRequest.requestPermissions(permissions);
  }

  static requestPermissionList(permissionList: Permissions[]): boolean {
    return PermissionsRequestUtil.permissionRequest.requestPermissionList(permissionList);
  }
}