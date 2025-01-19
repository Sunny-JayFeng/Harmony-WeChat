import { UIConstantValue } from 'constantvalue'
import FontConstantValue from 'constantvalue/src/main/ets/constant/FontConstantValue'

@Component
export default struct TopToolBar {
  @Prop currentTabTitle: string = ''

  build() {
    Stack() {
      Text(this.currentTabTitle)
        .fontSize(FontConstantValue.FONT_SIZE_18)
        .fontWeight(FontWeight.Bold)
        .height(UIConstantValue.HEIGHT_PERCENT_100)
        .width(UIConstantValue.WIDTH_PERCENT_100)
        .textAlign(TextAlign.Center)
      Row({ space: UIConstantValue.SPACE_10 }) {
        Image($r('app.media.topToolBarSearchIcon'))
          .width(UIConstantValue.WIDTH_32)
          .height(UIConstantValue.HEIGHT_32)
        Image($r('app.media.topToolBarAddIcon'))
          .width(UIConstantValue.WIDTH_28)
          .height(UIConstantValue.HEIGHT_28)
      }
      .padding({
        right: UIConstantValue.PADDING_10
      })
    }
    .alignContent(Alignment.End)
  }
}