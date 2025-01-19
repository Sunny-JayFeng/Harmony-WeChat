import { IContactListDataType } from "../../uiDataTypes/UIDataType";
import ContactClassifyDataViewModel from "./ContactClassifyDataViewModel";

/**
 * 联系人列表
 */
export default class ContactListDataViewModel {
  // 新的朋友、仅聊天的朋友等
  private static readonly contactClassifyData: IContactListDataType = {
    classifyName: '',
    dataList: ContactClassifyDataViewModel.getContactClassifyDataList()
  };
  // 企业微信联系人、企业微信通知
  private static readonly enterpriseClassifyData: IContactListDataType = {
    classifyName: '我的企业及企业联系人',
    dataList: ContactClassifyDataViewModel.getEnterpriseWeChatClassifyDataList()
  }

  static getContactClassifyData(): IContactListDataType {
    return ContactListDataViewModel.contactClassifyData
  }

  static getEnterpriseClassifyData(): IContactListDataType {
    return ContactListDataViewModel.enterpriseClassifyData
  }
}