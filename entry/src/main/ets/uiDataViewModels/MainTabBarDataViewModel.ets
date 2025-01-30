import { IMainTabBarDataType } from "../type/uiDataTypes/UIDataType";

export default class MainTabBarDataViewModel {
  private static readonly mainTabBarDataList: IMainTabBarDataType[] = [
    {
      id: 1,
      normalIcon: $r("app.media.mainTabWeChatNormalIcon"),
      selectedIcon: $r("app.media.mainTabWeChatSelectedIcon"),
      tabName: $r('app.string.mainTabBar_wechat'),
      tabTitle: $r('app.string.mainTabBarTitle_wechat')
    },
    {
      id: 2,
      normalIcon: $r("app.media.mainTabContactsNormalIcon"),
      selectedIcon: $r("app.media.mainTabContactsSelectedIcon"),
      tabName: $r('app.string.mainTabBar_contacts'),
      tabTitle: $r('app.string.mainTabBarTitle_contacts')
    },
    {
      id: 3,
      normalIcon: $r("app.media.mainTabFoundNormalIcon"),
      selectedIcon: $r("app.media.mainTabFoundSelectedIcon"),
      tabName: $r('app.string.mainTabBar_found'),
      tabTitle: $r('app.string.mainTabBarTitle_found')
    },
    {
      id: 4,
      normalIcon: $r("app.media.mainTabMineNormalIcon"),
      selectedIcon: $r("app.media.mainTabMineSelectedIcon"),
      tabName: $r('app.string.mainTabBar_mine'),
      tabTitle: $r('app.string.mainTabBarTitle_mine')
    },
  ]

  static getTabBarDataList(): IMainTabBarDataType[] {
    return MainTabBarDataViewModel.mainTabBarDataList
  }

  static isWeChatTab(index: number): boolean {
    return index === 0;
  }

  static isContactTab(index: number): boolean {
    return index === 1;
  }

  static isFoundTab(index: number): boolean {
    return index === 2;
  }

  static isMineTab(index: number): boolean {
    return index === 3;
  }
}
