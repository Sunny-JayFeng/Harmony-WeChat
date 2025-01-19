import { MineCardDataType, MineItemDataType } from "../../uiDataTypes/UIDataType";

/**
 * 我界面数据
 */
export default class MineContentListDataViewModel {
  private static dataList: Array<MineItemDataType[]> = [
    [
      {
        id: 0,
        itemIcon: $r('app.media.mineTabPayAndServicesIcon'),
        itemName: $r("app.string.pay_and_services")
      }
    ],
    [
      {
        id: 1,
        itemIcon: $r('app.media.mineTabFavoritesIcon'),
        itemName: $r('app.string.favorites')
      },
      {
        id: 2,
        itemIcon: $r('app.media.mineTabMyPostsIcon'),
        itemName: $r("app.string.my_posts")
      },
      {
        id: 3,
        itemIcon: $r('app.media.mineTabChannelsIcon'),
        itemName: $r('app.string.channels')
      },
      {
        id: 4,
        itemIcon: $r('app.media.mineTabCardAndOffersIcon'),
        itemName: $r("app.string.cards_and_offers")
      },
      {
        id: 5,
        itemIcon: $r('app.media.mineTabStickerGalleryIcon'),
        itemName: $r("app.string.sticker_gallery")
      }
    ],
    [
      {
        id: 6,
        itemIcon: $r('app.media.mineTabSettingsIcon'),
        itemName: $r('app.string.settings')
      }
    ]
  ]
  private static mineCardData: MineCardDataType = { // 临时设置，后面请求响应调用 set 接口设置
    account: 'xiaohaitun',
    userName: '小海豚',
    state: 0,
    avatar: $r('app.media.testAvatar'),
    friendNewStateCount: 5,
    friendAvatarList: [
      $r('app.media.testAvatar'),
      $r('app.media.testAvatar'),
      $r('app.media.testAvatar')
    ]
  }

  static getMineContentDataList(): Array<MineItemDataType[]> {
    return MineContentListDataViewModel.dataList
  }

  static setMineCardData(mineCardData: MineCardDataType) {
    MineContentListDataViewModel.mineCardData = mineCardData;
  }

  static getMineCardData(): MineCardDataType {
    return MineContentListDataViewModel.mineCardData;
  }

  static hasState(): boolean {
    return MineContentListDataViewModel.mineCardData.state !== 0;
  }

}