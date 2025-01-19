import { router } from '@kit.ArkUI';
import { FontConstantValue, UIConstantValue } from 'constantvalue';
import ItemInput from '../register/RegisterPage';

@Entry
@Component
struct LoginPage {
  @State loginByAccount: boolean = true;
  @State loginByVerifyCode: boolean = false;
  @Provide('accountValue') accountValue: string = ''
  @Provide('passwordValue') passwordValue: string = ''
  @Provide('phoneNumber') phoneNumber: string = '';

  // 关闭页面
  onCloseButtonClicked() {
    router.replaceUrl({
      url: 'pages/HomePage'
    })
  }

  buttonClickable(): boolean {
    return this.loginByAccount ?
      (this.accountValueIsRight() && this.passwordValueIsRight())
      : (this.phoneNumberIsRight() && this.passwordValueIsRight());
  }

  accountValueIsRight(): boolean {
    return this.accountValue !== '';
  }

  passwordValueIsRight(): boolean {
    return this.passwordValue !== '';
  }

  phoneNumberIsRight(): boolean {
    return this.phoneNumber !== '';
  }

  // 处理登录
  onLoginButtonClicked() {
    if (!this.buttonClickable()) { // 再次校验
      return
    }
  }

  // 找回密码
  onFoundPasswordClicked() {

  }

  // 紧急冻结
  onEmergencyFreezingClicked() {

  }

  // 安全中心
  onSecurityCenterClicked() {

  }

  // 更多选项
  onMoreOptionsClicked() {

  }

  build() {
    Column() {
      // 关闭图标
      Row() {
        Image($r('app.media.closeIcon'))
          .width(20)
          .height(20)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .onClick(this.onCloseButtonClicked)

      // 登录类型文本
      Row() {
        Text(this.loginByAccount ? $r('app.string.account_login') : $r('app.string.phone_login'))
          .fontSize(18)
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .margin({
        top: '15%'
      })

      // 输入组件
      Row() {
        if (this.loginByAccount) {
          LoginByAccount()
        } else {
          LoginByPhoneNumber()
        }
      }
      .margin({
        top: '7%'
      })

      // 用手机号登录 / 账号密码登录
      Row() {
        Text(this.loginByAccount ? $r('app.string.login_by_phone_number') : $r('app.string.login_by_account'))
          .fontSize(16)
          .fontColor($r("app.color.change_login_type_button_color"))
          .margin({
            top: '6%'
          })
          .onClick(() => {
            this.loginByAccount = !this.loginByAccount
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      // 信息提示
      Row() {
        Text(this.loginByAccount ? $r("app.string.account_login_statement") : $r('app.string.phone_login_statement'))
          .fontSize(12)
          .fontColor($r('app.color.login_statement_font_color'))
      }
      .margin({
        top: this.loginByAccount ? '90%' : '80%'
      })

      // 按钮
      Row() {
        Button($r("app.string.agree_and_login"), { type: ButtonType.Normal })
          .width(UIConstantValue.WIDTH_PERCENT_50)
          .height(UIConstantValue.HEIGHT_PERCENT_5)
          .borderRadius(UIConstantValue.BORDER_RADIUS_5)
          .fontSize(FontConstantValue.FONT_SIZE_14)
          .fontColor(this.buttonClickable() ? Color.White : $r('app.color.login_button_font_color'))
          .backgroundColor(this.buttonClickable() ? $r('app.color.login_page_clickable_button_color') :
          $r('app.color.login_page_button_color'))
          .margin({
            top: UIConstantValue.MARGIN_PERCENT_6
          })
          .onClick(this.onLoginButtonClicked)
      }

      Row({ space: 8 }) {
        // 找回密码
        Text($r('app.string.found_password'))
          .fontSize(12)
          .fontColor($r("app.color.change_login_type_button_color"))
          .onClick(this.onFoundPasswordClicked)
        Divider().vertical(true).color($r('app.color.login_page_divider_color')).height(18).strokeWidth(1)
        if (this.loginByAccount) {
          // 紧急冻结
          Text($r('app.string.emergency_freezing'))
            .fontSize(12)
            .fontColor($r("app.color.change_login_type_button_color"))
            .onClick(this.onEmergencyFreezingClicked)
          Divider().vertical(true).color($r('app.color.login_page_divider_color')).height(18).strokeWidth(1)
          // 安全中心
          Text($r('app.string.security_center'))
            .fontSize(12)
            .fontColor($r("app.color.change_login_type_button_color"))
            .onClick(this.onSecurityCenterClicked)
        } else {
          // 更多选项
          Text($r('app.string.more_options'))
            .fontSize(12)
            .fontColor($r("app.color.change_login_type_button_color"))
            .onClick(this.onMoreOptionsClicked)
        }
      }
      .margin({
        top: '15%'
      })

    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.background_color'))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .padding({
      left: '5%',
      top: '5%',
      right: '5%'
    })
  }
}

// 账号密码登录
@Component
struct LoginByAccount {
  @Consume('accountValue') accountValue: string;
  @Consume('passwordValue') passwordValue: string;

  build() {
    Column() {
      ItemInput({
        placeholder: $r('app.string.account_input_placeholder'),
        itemName: $r('app.string.login_account_input_name'),
        inputBorderColor: $r('app.color.border_color'),
        itemValue: this.accountValue
      })
      ItemInput({
        placeholder: $r('app.string.password_input_placeholder'),
        itemName: $r('app.string.password_input_name'),
        inputBorderColor: $r('app.color.border_color'),
        itemValue: this.passwordValue,
        inputType: InputType.Password
      })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// 手机号登录
@Component
struct LoginByPhoneNumber {
  @Consume('phoneNumber') phoneNumber: string;
  @Consume('passwordValue') passwordValue: string;
  @State private area: string = '中国大陆 (+86)'

  build() {
    Column() {
      ItemInput({
        placeholder: $r('app.string.register_area_select_placeholder'),
        itemName: $r('app.string.register_area_input'),
        valueColor: $r('app.color.register_area_font_color'),
        inputBorderColor: $r('app.color.border_color'),
        itemValue: this.area,
      })
      ItemInput({
        placeholder: $r("app.string.login_phone_input_placeholder"),
        itemName: $r('app.string.login_phone'),
        inputBorderColor: $r('app.color.border_color'),
        itemValue: this.phoneNumber,
      })
      ItemInput({
        placeholder: $r('app.string.password_input_placeholder'),
        itemName: $r("app.string.password_input_name"),
        inputBorderColor: $r('app.color.border_color'),
        itemValue: this.passwordValue,
      })
    }
  }
}