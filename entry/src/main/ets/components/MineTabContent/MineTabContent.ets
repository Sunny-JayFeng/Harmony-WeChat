import { AppStorageKey, UIConstantValue } from "constantvalue"
import { MineItemDataType } from "../../type/uiDataTypes/UIDataType"
import MineContentListDataViewModel from "../../uiDataViewModels/mine/MineContentListDataViewModel"
import MineCard from "./MineCard"
import MineItem from "./MineItem"

@Component
export default struct MineTabContent {
  @Builder
  groupHeader() {
    Row()
      .width(UIConstantValue.WIDTH_PERCENT_100)
      .height(UIConstantValue.HEIGHT_10)
  }

  build() {
    Column() {
      Column() {
        MineCard()
        Row()
          .width(UIConstantValue.WIDTH_PERCENT_100)
          .height(UIConstantValue.HEIGHT_10)
        List() {
          ForEach(MineContentListDataViewModel.getMineContentDataList(),
            (dataList: MineItemDataType[], index: number) => {
              ListItemGroup({ header: this.groupHeader() }) {
                ForEach(dataList, (data: MineItemDataType, index: number) => {
                  MineItem({
                    itemData: data,
                    hasBorder: (dataList.length > 1 && index !== dataList.length - 1)
                  })
                }, (itemIndex: number) => itemIndex.toString())
              }
            }, (listIndex: number) => listIndex.toString())
        }
        .width(UIConstantValue.WIDTH_PERCENT_100)
        .height(UIConstantValue.HEIGHT_PERCENT_100)
      }
    }
  }
}