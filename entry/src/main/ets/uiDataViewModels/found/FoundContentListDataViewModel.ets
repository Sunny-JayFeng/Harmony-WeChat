import { FoundItemDataType } from "../../uiDataTypes/UIDataType";

/**
 * 发现列表
 */
export default class FoundContentListDataViewModel {
  private static dataList: Array<FoundItemDataType[]> = [
    [
      {
        id: 0,
        itemIcon: $r('app.media.foundTabMomentsIcon'),
        itemName: $r('app.string.moments'),
        message: '',
        avatarImg: ''
      }
    ],
    [
      {
        id: 1,
        itemIcon: $r('app.media.foundTabChannelsIcon'),
        itemName: $r('app.string.channels'),
        message: '',
        avatarImg: ''
      },
      {
        id: 2,
        itemIcon: $r('app.media.foundTabLiveStreamIcon'),
        itemName: $r('app.string.channels'),
        message: '',
        avatarImg: ''
      }
    ],
    [
      {
        id: 3,
        itemIcon: $r('app.media.foundTabScanIcon'),
        itemName: $r('app.string.scan'),
        message: '',
        avatarImg: ''
      },
      {
        id: 4,
        itemIcon: $r('app.media.foundTabListenIcon'),
        itemName: $r('app.string.listen'),
        message: '',
        avatarImg: ''
      }
    ],
    [
      {
        id: 5,
        itemIcon: $r('app.media.foundTabTopStoriesIcon'),
        itemName: $r("app.string.top_stories"),
        message: '',
        avatarImg: ''
      },
      {
        id: 6,
        itemIcon: $r('app.media.foundTabSearchIcon'),
        itemName: $r('app.string.search'),
        message: '',
        avatarImg: ''
      }
    ],
    [
      {
        id: 7,
        itemIcon: $r('app.media.foundTabNearbyIcon'),
        itemName: $r('app.string.nearby'),
        message: '',
        avatarImg: ''
      }
    ],
    [
      {
        id: 8,
        itemIcon: $r('app.media.foundTabGamesIcon'),
        itemName: $r('app.string.game'),
        message: '',
        avatarImg: ''
      }
    ],
    [
      {
        id: 9,
        itemIcon: $r('app.media.foundTabMiniProgramsIcon'),
        itemName: $r("app.string.mini_programs"),
        message: '',
        avatarImg: ''
      }
    ]
  ]

  static getFoundContentDataList(): Array<FoundItemDataType[]> {
    return FoundContentListDataViewModel.dataList
  }
}