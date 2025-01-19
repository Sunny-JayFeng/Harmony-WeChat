import FontConstantValue from 'constantvalue/src/main/ets/constant/FontConstantValue';
import UIConstantValue from 'constantvalue/src/main/ets/constant/UIConstantValue'

@Component
export default struct ContactItem {
  @Prop contactAvatarImg: Resource;
  @Prop contactName: Resource;

  build() {
    Row({ space: UIConstantValue.SPACE_10 }) {
      Image(this.contactAvatarImg)
        .width(UIConstantValue.WIDTH_35)
        .height(UIConstantValue.HEIGHT_35)
        .objectFit(ImageFit.Contain)
      Text(this.contactName)
        .fontSize(FontConstantValue.FONT_SIZE_14)
    }
    .padding(UIConstantValue.PADDING_10)
    .width('100%')
    .backgroundColor($r('app.color.contact_item_bkg_color'))
    .border({
      width: {
        top: UIConstantValue.BORDER_WIDTH_0_5,
      },
      color: $r('app.color.border_color')
    })
  }
}