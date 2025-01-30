import { MineItemDataType } from "../../type/uiDataTypes/UIDataType";

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

  static getMineContentDataList(): Array<MineItemDataType[]> {
    return MineContentListDataViewModel.dataList
  }

}