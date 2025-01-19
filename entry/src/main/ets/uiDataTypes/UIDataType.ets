// tab 类型
export interface IMainTabBarDataType {
  id: number;
  normalIcon: ResourceStr;
  selectedIcon: ResourceStr;
  tabName: ResourceStr;
  tabTitle: ResourceStr;
}

// 微信 tab 单个 item
export interface ChatItemDataType {
  imgUrl: string; // 头像-server 给的 imgUrl
  title: string; // 名称
  latestMessageTime: string; // 最新一条记录的时间
  latestMessage: string; // 最新一条记录的内容
  isTop: boolean; // 是否置顶
}

// 通讯录 tab，单个 item
export interface ContactDataType {
  id: number;
  avatarImg: Resource;
  contactName: Resource;
}

// 通讯里 item 列表
export class IContactListDataType {
  // 分类
  classifyName: string = '';
  // 数据列表
  dataList: ContactDataType[] = [];
}

// 发现 tab 单个 item
export interface FoundItemDataType {
  id: number,
  itemIcon: Resource; // item 图标
  itemName: Resource; // item 名称
  message: string; // 右侧的信息内容
  avatarImg: string; // 右侧的用户头像-例如朋友圈有更新时的头像
}

// 我 tab-用户卡片信息
export interface MineCardDataType {
  account: string; // 微信号
  userName: string; // 微信名
  state: number; // 状态。 0 表示没有状态
  avatar: string | Resource; // 头像
  friendNewStateCount: number; // 更新了状态的朋友数量
  friendAvatarList: string[] | Resource[]; // 更新了状态的朋友的头像，最多显示3个头像
}

// 我 tab 单个 item
export interface MineItemDataType {
  id: number,
  itemIcon: Resource; // item 图标
  itemName: Resource; // item 名称
}