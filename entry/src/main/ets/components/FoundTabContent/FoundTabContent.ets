import { FontConstantValue, UIConstantValue } from "constantvalue"
import { FoundItemDataType } from "../../type/uiDataTypes/UIDataType"
import FoundContentListDataViewModel from "../../uiDataViewModels/found/FoundContentListDataViewModel"
import FoundItem from "./FoundItem"

@Component
export default struct FoundTabContent {
  @Builder
  groupHeader(index: number) {
    if (index !== 0) {
      Row() {

      }
      .width(UIConstantValue.WIDTH_PERCENT_100)
      .height(UIConstantValue.HEIGHT_10)
    }
  }

  build() {
    Column() {
      List() {
        ForEach(FoundContentListDataViewModel.getFoundContentDataList(),
          (dataList: FoundItemDataType[], index: number) => {
            ListItemGroup({ header: this.groupHeader(index) }) {
              ForEach(dataList, (data: FoundItemDataType, index: number) => {
                FoundItem({
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