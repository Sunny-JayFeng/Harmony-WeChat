import ItemInput from '../register/RegisterPage';
import { AgreeButton, ChangeLoginType, CloseIcon, LoginTypeText, SelfHelpText, StatementTip } from './BaseComponent';
import { router } from '@kit.ArkUI';
import { RouterUrlConstantValue, UIConstantValue } from 'constantvalue';

export class PhoneMessage {
  constructor(areaNumber: string, phoneNumber: string) {
    this.areaNumber = areaNumber;
    this.phoneNumber = phoneNumber;
  }

  areaNumber: string;
  phoneNumber: string;
}

@Entry
@Component
struct LoginByPhoneNumber {
  @State phoneNumber: string = '';
  @State area: string = '中国大陆 (+86)'
  @State areaNumber: string = '+86'

  buttonClickable(): boolean {
    return this.phoneNumberIsRight()
  }

  phoneNumberIsRight(): boolean {
    return this.phoneNumber != ''
  }

  // 点击关闭
  onCloseButtonClicked() {
    router.replaceUrl({
      url: RouterUrlConstantValue.HOME_PAGE_URL
    })
  }

  // 切换为手机验证码登录
  onChangeLoginTypeClicked() {
    router.replaceUrl({
      url: RouterUrlConstantValue.LOGIN_BY_ACCOUNT
    })
  }

  // 点击同意并继续
  onAgreeButtonClicked() {
    router.pushUrl(
      {
        url: RouterUrlConstantValue.LOGIN_BY_PHONE_NUMBER_STEP_TWO,
        params: new PhoneMessage(this.areaNumber, this.phoneNumber)
      },
      router.RouterMode.Single
    )
  }

  build() {
    Column() {
      // 关闭按钮
      CloseIcon()
        .onClick(this.onCloseButtonClicked)
      // 登录类型文本
      Row() {
        LoginTypeText({
          loginType: $r('app.string.phone_login')
        })
      }
      .width(UIConstantValue.WIDTH_PERCENT_100)
      .justifyContent(FlexAlign.Center)
      .margin({
        top: UIConstantValue.MARGIN_PERCENT_15
      })

      // 输入框
      Column() {
        ItemInput({
          placeholder: $r('app.string.register_area_select_placeholder'),
          itemName: $r('app.string.register_area_input'),
          valueColor: $r('app.color.register_area_font_color'),
          inputBorderColor: $r('app.color.border_color'),
          itemValue: this.area
        })
        ItemInput({
          placeholder: $r("app.string.login_phone_input_placeholder"),
          itemName: $r('app.string.login_phone'),
          inputBorderColor: $r('app.color.border_color'),
          itemValue: this.phoneNumber,
        })
      }
      .alignItems(HorizontalAlign.Start)
      .width(UIConstantValue.WIDTH_PERCENT_100)
      .margin({ top: UIConstantValue.MARGIN_PERCENT_7 })

      // 切换为手机验证码登录
      ChangeLoginType({
        loginType: $r('app.string.login_by_account')
      }).margin({
        top: UIConstantValue.MARGIN_PERCENT_6
      }).onClick(this.onChangeLoginTypeClicked)

      // 隐私提示
      Row() {
        StatementTip({
          statementTip: $r('app.string.phone_login_statement')
        }).margin({ top: UIConstantValue.MARGIN_PERCENT_90 })
      }
      .width(UIConstantValue.WIDTH_PERCENT_100)
      .justifyContent(FlexAlign.Center)

      // 同意并登录按钮
      Row() {
        AgreeButton({
          buttonText: $r('app.string.agree_and_continue'),
          buttonClickable: this.buttonClickable()
        }).onClick(() => {
          this.onAgreeButtonClicked()
        })
      }
      .width(UIConstantValue.WIDTH_PERCENT_100)
      .justifyContent(FlexAlign.Center)
      .margin({
        top: UIConstantValue.MARGIN_PERCENT_6
      })

      // 其他服务：找回密码等
      Row({ space: UIConstantValue.SPACE_8 }) {
        SelfHelpText({
          text: $r('app.string.found_password'),
          hasDivider: true,
          onTextClick: (): void => {
            AlertDialog.show({ message: '跳转到找回密码页面' })
          }
        })
        SelfHelpText({
          text: $r('app.string.more_options'),
          onTextClick: (): void => {
            AlertDialog.show({ message: '弹出更多选项' })
          }
        })
      }
      .width(UIConstantValue.WIDTH_PERCENT_100)
      .justifyContent(FlexAlign.Center)
      .margin({
        top: UIConstantValue.MARGIN_PERCENT_15
      })
    }
    .width(UIConstantValue.WIDTH_PERCENT_100)
    .height(UIConstantValue.HEIGHT_PERCENT_100)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor($r('app.color.background_color'))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .padding({
      left: UIConstantValue.PADDING_PERCENT_5,
      top: UIConstantValue.PADDING_PERCENT_5,
      right: UIConstantValue.PADDING_PERCENT_5
    })
  }
}