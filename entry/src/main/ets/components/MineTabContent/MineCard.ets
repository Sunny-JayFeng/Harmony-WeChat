import { FontConstantValue, UIConstantValue } from "constantvalue";
import { MineCardDataType } from "../../uiDataTypes/UIDataType"

@Component
export default struct MineCard {
  @Prop mineCardData: MineCardDataType;

  hasState(): boolean {
    return this.mineCardData.state !== 0;
  }

  build() {
    Column() {
      Row() {
        Row({ space: UIConstantValue.SPACE_10 }) {
          Column() {
            Image(this.mineCardData.avatar)
              .width(UIConstantValue.WIDTH_65)
              .height(UIConstantValue.HEIGHT_65)
              .borderRadius(UIConstantValue.BORDER_RADIUS_10)
          }
          .justifyContent(FlexAlign.Start)

          Column({ space: UIConstantValue.SPACE_10 }) {
            Text(this.mineCardData.userName)
              .fontSize(FontConstantValue.FONT_SIZE_18)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.hasState() ? Color.White : $r('app.color.mine_card_name_font_color'))
            Column({ space: UIConstantValue.SPACE_5 }) {
              Text($r('app.string.we_chat_account'))
                .fontSize(FontConstantValue.FONT_SIZE_12)
                .fontColor(this.hasState() ? $r('app.color.mine_card_has_state_font_color') :
                $r('app.color.mine_card_font_color'))
              Text(this.mineCardData.account)
                .fontSize(FontConstantValue.FONT_SIZE_12)
                .fontColor(this.hasState() ? $r('app.color.mine_card_has_state_font_color') :
                $r('app.color.mine_card_font_color'))
            }
            .alignItems(HorizontalAlign.Start)

            if (!this.hasState()) {
              NoStateComponent({
                mineCardData: this.mineCardData
              })
            }
          }
          .alignItems(HorizontalAlign.Start)
        }
        .alignItems(VerticalAlign.Top)

        Column() {
          Row() {
            Image(this.hasState() ? $r('app.media.mineCardHasStateQrCodeIcon') : $r('app.media.mineCardQrCodeIcon'))
              .width(UIConstantValue.WIDTH_20)
              .height(UIConstantValue.HEIGHT_20)
              .objectFit(ImageFit.Contain)
            Image(this.hasState() ? $r('app.media.mineCardHasStateRightArrowIcon') :
            $r('app.media.mineCardRightArrowIcon'))
              .width(UIConstantValue.WIDTH_12)
              .height(UIConstantValue.HEIGHT_12)
              .objectFit(ImageFit.Contain)
              .fillColor(Color.White)
          }
        }
        .justifyContent(FlexAlign.Center)
      }
      .width(UIConstantValue.WIDTH_PERCENT_100)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)

      if (this.hasState()) {
        Row() {
          StateComponent()
        }
      }
    }
    .width('100%')
    .padding(UIConstantValue.PADDING_20)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    .backgroundColor(this.hasState() ? $r('app.color.mine_card_has_state_bkg_color') :
    $r('app.color.mine_card_bkg_color'))
  }
}

@Component
struct StateComponent {
  @Prop mineCardData: MineCardDataType;

  build() {
    Column({ space: UIConstantValue.SPACE_5 }) {
      Row() {
        Text('开心')// 设置我的状态时填写的状态词-如果没有 text 的话, 那要去掉这个 column
          .fontSize(FontConstantValue.FONT_SIZE_16)
          .fontColor($r('app.color.mine_card_has_state_font_color'))
      }
      .width('100%')

      Row() {
        Row({ space: UIConstantValue.SPACE_5 }) {
          Image($r('app.media.happyStateIcon'))// 根据状态获取图标
            .width(UIConstantValue.WIDTH_18)
            .height(UIConstantValue.HEIGHT_18)
            .objectFit(ImageFit.Contain)
          Text('美滋滋')// 根据状态获取状态名称
            .fontSize(FontConstantValue.FONT_SIZE_14)
            .fontColor($r('app.color.mine_card_has_state_font_color'))
          Image($r('app.media.mineCardHasStateRightArrowIcon'))
            .width(UIConstantValue.WIDTH_18)
            .height(UIConstantValue.HEIGHT_18)
            .objectFit(ImageFit.Contain)
        }

        Stack() {
          Row() {
            Image($r('app.media.stateOptIcon'))
              .width(UIConstantValue.WIDTH_18)
              .height(UIConstantValue.HEIGHT_18)
              .objectFit(ImageFit.Contain)
          }
          .width(UIConstantValue.WIDTH_20)
          .height(UIConstantValue.HEIGHT_20)

          Row() {

          }
          .width(UIConstantValue.WIDTH_20)
          .height(UIConstantValue.HEIGHT_20)
          .borderRadius(UIConstantValue.BORDER_RADIUS_50)
          .backgroundColor(Color.Black)
          .opacity(UIConstantValue.Opacity_0_POINT_1)
        }

      }
      .width(UIConstantValue.WIDTH_PERCENT_100)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(UIConstantValue.WIDTH_PERCENT_100)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .margin({
      top: UIConstantValue.MARGIN_10,
    })
    .padding({
      top: UIConstantValue.PADDING_10
    })
    .border({
      width: {
        top: UIConstantValue.BORDER_WIDTH_0_7
      },
      color: $r('app.color.mine_card_has_state_border_color')
    })
  }
}

@Component
struct NoStateComponent {
  @Prop mineCardData: MineCardDataType;
  @State account: number = 0;

  aboutToAppear(): void {
    this.account = this.mineCardData.friendNewStateCount;
  }

  build() {
    Row({ space: UIConstantValue.SPACE_10 }) {
      Row() {
        Image($r('app.media.mineTabAddStateIcon'))
          .width(UIConstantValue.WIDTH_14)
          .height(UIConstantValue.HEIGHT_14)
        Text($r('app.string.state'))
          .fontSize(FontConstantValue.FONT_SIZE_12)
          .fontColor($r('app.color.mine_card_font_color'))
      }
      .border({
        width: UIConstantValue.BORDER_WIDTH_0_5,
        color: $r('app.color.border_color')
      })
      .borderRadius(UIConstantValue.BORDER_RADIUS_20)
      .padding({
        left: UIConstantValue.PADDING_5,
        top: UIConstantValue.PADDING_2,
        right: UIConstantValue.PADDING_5,
        bottom: UIConstantValue.PADDING_2
      })

      Row({ space: UIConstantValue.SPACE_5 }) {
        Row() {
          ForEach(this.mineCardData.friendAvatarList, (avatarItem: string, index: number) => {
            Image(avatarItem)
              .width(UIConstantValue.WIDTH_18)
              .height(UIConstantValue.HEIGHT_18)
              .borderRadius(UIConstantValue.BORDER_RADIUS_50)

          }, (index: number) => index.toString())
        }

        Row() {
          if (this.account > 0) {
            Text(this.account > 3 ? $r('app.string.more_friend_count', this.account) : $r('app.string.friend_count', this.account))
              .fontSize(FontConstantValue.FONT_SIZE_12)
              .fontColor($r('app.color.mine_card_font_color'))
          } else {
            Image($r('app.media.noNewStateIcon'))
              .width(UIConstantValue.WIDTH_10)
              .height(UIConstantValue.HEIGHT_10)
              .objectFit(ImageFit.Contain)
          }
        }

        if (this.account > 3) {
          Row() {

          }
          .width(UIConstantValue.WIDTH_5)
          .height(UIConstantValue.HEIGHT_5)
          .borderRadius(UIConstantValue.BORDER_RADIUS_50)
          .backgroundColor(Color.Red)
        }
      }
      .border({
        width: UIConstantValue.BORDER_WIDTH_0_5,
        color: $r('app.color.border_color')
      })
      .borderRadius(UIConstantValue.BORDER_RADIUS_20)
      .padding({
        left: UIConstantValue.PADDING_5,
        top: UIConstantValue.PADDING_2,
        right: UIConstantValue.PADDING_5,
        bottom: UIConstantValue.PADDING_2
      })
    }
  }
}
