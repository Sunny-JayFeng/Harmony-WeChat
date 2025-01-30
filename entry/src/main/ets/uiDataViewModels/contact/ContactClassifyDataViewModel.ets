import { ContactDataType } from "../../type/uiDataTypes/UIDataType";

export default class ContactClassifyDataViewModel {
  private static readonly classifyDataList: ContactDataType[] = [
    {
      id: 1,
      avatarImg: $r('app.media.newFriendImg'),
      contactName: $r('app.string.new_friend')
    },
    {
      id: 2,
      avatarImg: $r('app.media.justChatFriendImg'),
      contactName: $r('app.string.just_chat_friend')
    },
    {
      id: 3,
      avatarImg: $r("app.media.chatGroupImg"),
      contactName: $r('app.string.chat_group')
    },
    {
      id: 4,
      avatarImg: $r("app.media.contactTagImg"),
      contactName: $r('app.string.contact_tag')
    },
    {
      id: 5,
      avatarImg: $r('app.media.officialAccountImg'),
      contactName: $r('app.string.official_account')
    },
    {
      id: 6,
      avatarImg: $r('app.media.serviceAccountImg'),
      contactName: $r('app.string.service_account')
    }
  ]
  private static readonly enterpriseWeChatClassifyList: ContactDataType[] = [
    {
      id: 7,
      avatarImg: $r('app.media.enterpriseWeChatContactImg'),
      contactName: $r('app.string.enterprise_we_chat_contact')
    },
    {
      id: 8,
      avatarImg: $r('app.media.enterpriseWeChatNotifyImg'),
      contactName: $r('app.string.enterprise_we_chat_notify_contact')
    }
  ];

  static getContactClassifyDataList(): ContactDataType[] {
    return ContactClassifyDataViewModel.classifyDataList
  }

  static getEnterpriseWeChatClassifyDataList(): ContactDataType[] {
    return ContactClassifyDataViewModel.enterpriseWeChatClassifyList;
  }
}