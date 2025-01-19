import { abilityAccessCtrl, common, PermissionRequestResult, Permissions } from "@kit.AbilityKit";
import { BusinessError } from "@kit.BasicServicesKit";

export default class PermissionRequest {
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
  private atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();

  public requestPermissions(permission: Permissions): boolean {
    let result: boolean = false;
    this.atManager.requestPermissionsFromUser(this.context, [permission])
      .then((requestResult: PermissionRequestResult) => {
        result = requestResult.authResults[0] === 0;
      })
      .catch((error: BusinessError) => {
        // 打印错误日志
        result = false;
      })
    return result;
  }

  public requestPermissionList(permissionList: Permissions[]) {
    let result: boolean = false;
    this.atManager.requestPermissionsFromUser(this.context, permissionList)
      .then((requestResult: PermissionRequestResult) => {
        requestResult.authResults.forEach(element => {
          if (element !== 0) {
            result = false;
          }
        });
        result = true;
      })
      .catch((error: BusinessError) => {
        // 打印错误日志
        result = false;
      })
    return result;
  }
}