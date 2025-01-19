import { FontConstantValue, UIConstantValue } from 'constantvalue';
import { ChatItemDataType } from '../../uiDataTypes/UIDataType'

@Component
export default struct ChartItem {
  @Prop chatItemData: ChatItemDataType;

  build() {
    Row() {
      Row({ space: UIConstantValue.SPACE_10 }) {
        Image(this.chatItemData.imgUrl)
          .width(UIConstantValue.WIDTH_45)
          .height(UIConstantValue.HEIGHT_45)
          .objectFit(ImageFit.Contain)
        Column({ space: UIConstantValue.SPACE_5 }) {
          Text(this.chatItemData.title)
            .fontSize(FontConstantValue.FONT_SIZE_16)
          Text(this.chatItemData.latestMessage)
            .fontSize(FontConstantValue.FONT_SIZE_12)
            .fontColor(this.chatItemData.isTop ? $r('app.color.chat_item_top_latest_message_font_color') :
            $r('app.color.chat_item_latest_message_font_color'))
        }
        .alignItems(HorizontalAlign.Start)
      }

      Text(this.chatItemData.latestMessageTime)
        .fontSize(FontConstantValue.FONT_SIZE_12)
        .fontColor(this.chatItemData.isTop ? $r('app.color.chat_item_top_time_font_color') :
        $r('app.color.chat_item_time_font_color'))
    }
    .alignItems(VerticalAlign.Top)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(this.chatItemData.isTop ? $r('app.color.chat_item_top_background_color') :
    $r('app.color.chat_item_normal_background_color'))
    .width(UIConstantValue.WIDTH_PERCENT_100)
    .height(UIConstantValue.HEIGHT_60)
    .padding(UIConstantValue.PADDING_10)
    .border({
      width: {
        top: UIConstantValue.BORDER_WIDTH_0_5
      },
      color: $r('app.color.border_color')
    })
  }
}