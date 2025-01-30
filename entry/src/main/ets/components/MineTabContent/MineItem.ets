import { FontConstantValue, UIConstantValue } from "constantvalue";
import { MineItemDataType } from "../../type/uiDataTypes/UIDataType";

@Component
export default struct MineItem {
  @Prop itemData: MineItemDataType;
  @Prop hasBorder: boolean = false;

  build() {
    Row() {
      Row() {
        Image(this.itemData.itemIcon)
          .width(UIConstantValue.WIDTH_25)
          .height(UIConstantValue.HEIGHT_25)
          .objectFit(ImageFit.Contain)
      }
      .padding(UIConstantValue.PADDING_15)

      Row() {
        Text(this.itemData.itemName)
          .fontSize(FontConstantValue.FONT_SIZE_16)
          .fontColor($r('app.color.font_color'))
        Image($r('app.media.rightArrowIcon'))
          .width(UIConstantValue.WIDTH_18)
          .height(UIConstantValue.HEIGHT_18)
          .objectFit(ImageFit.Contain)
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding(UIConstantValue.PADDING_15)
      .border({
        width: {
          bottom: this.hasBorder ? UIConstantValue.BORDER_WIDTH_0_5 : 0
        },
        color: $r('app.color.border_color')
      })
    }
    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
    .backgroundColor($r('app.color.found_item_bkg_color'))
    .width(UIConstantValue.WIDTH_PERCENT_100)
  }
}