import { FontConstantValue, RouterUrlConstantValue, UIConstantValue } from 'constantvalue';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct HomePage {
  onLoginButtonClicked() {
    // 跳转登录页面
    router.replaceUrl({
      url: RouterUrlConstantValue.LOGIN_BY_PHONE_NUMBER_STEP_ONE
    })
  }

  onRegisterButtonClicked() {
    // 跳转注册页面
    router.replaceUrl({
      url: RouterUrlConstantValue.REGISTER_PAGE
    })
  }

  build() {
    Column() {
      Row() {
        // 登录
        Button($r('app.string.login'), { type: ButtonType.Normal, stateEffect: true })
          .backgroundColor($r('app.color.login_button_color'))
          .fontSize(FontConstantValue.FONT_SIZE_18)
          .borderRadius(UIConstantValue.BORDER_RADIUS_5)
          .width(UIConstantValue.WIDTH_PERCENT_35)
          .height(UIConstantValue.HEIGHT_45)
          .onClick(this.onLoginButtonClicked)
        // 注册
        Button($r('app.string.register'), { type: ButtonType.Normal, stateEffect: true })
          .backgroundColor($r('app.color.register_button_color'))
          .fontColor($r('app.color.register_button_text_color'))
          .fontSize(FontConstantValue.FONT_SIZE_18)
          .borderRadius(UIConstantValue.BORDER_RADIUS_5)
          .width(UIConstantValue.HEIGHT_PERCENT_35)
          .height(UIConstantValue.HEIGHT_45)
          .onClick(this.onRegisterButtonClicked)
      }
      .padding({
        left: UIConstantValue.PADDING_20,
        right: UIConstantValue.PADDING_20,
        bottom: UIConstantValue.PADDING_10
      })
      .width(UIConstantValue.WIDTH_PERCENT_100)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .justifyContent(FlexAlign.End)
    .backgroundImage($r('app.media.bkgImg'))
    .backgroundImageSize(ImageSize.Cover)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .width(UIConstantValue.WIDTH_PERCENT_100)
    .height(UIConstantValue.HEIGHT_PERCENT_100)
  }
}