import { FontConstantValue, UIConstantValue } from "constantvalue"
import { FoundItemDataType } from "../../uiDataTypes/UIDataType"

@Component
export default struct FoundItem {
  @Prop itemData: FoundItemDataType;
  @Prop hasBorder: boolean = false;

  build() {
    Row() {
      Row() {
        Image(this.itemData.itemIcon)
          .width(UIConstantValue.WIDTH_25)
          .height(UIConstantValue.HEIGHT_25)
          .objectFit(ImageFit.Contain)
      }
      .padding(UIConstantValue.PADDING_10)

      Row() {
        Text(this.itemData.itemName)
          .fontSize(FontConstantValue.FONT_SIZE_16)
          .fontColor($r('app.color.font_color'))
        Row({ space: UIConstantValue.SPACE_10 }) {
          Text(this.itemData.message)
            .fontSize(FontConstantValue.FONT_SIZE_14)
            .fontColor($r('app.color.found_message_font_color'))
          Image(this.itemData.avatarImg)
            .width(UIConstantValue.WIDTH_30)
            .height(UIConstantValue.HEIGHT_30)
            .objectFit(ImageFit.Contain)
          Image($r('app.media.rightArrowIcon'))
            .width(UIConstantValue.WIDTH_18)
            .height(UIConstantValue.HEIGHT_18)
            .objectFit(ImageFit.Contain)
        }
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding(UIConstantValue.PADDING_10)
      .border({
        width: {
          bottom: this.hasBorder ? UIConstantValue.BORDER_WIDTH_0_7 : 0
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