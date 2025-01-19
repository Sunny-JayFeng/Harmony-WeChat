import cloud, { VerifyCodeAction } from '@hw-agconnect/cloud';
import { BusinessConstantValue, FontConstantValue, RouterUrlConstantValue, UIConstantValue } from 'constantvalue';
import ItemInput from '../register/RegisterPage';
import { AgreeButton, ChangeLoginType, CloseIcon, LoginTypeText, SelfHelpText, StatementTip } from './BaseComponent';
import { BusinessError } from '@kit.BasicServicesKit';
import { router } from '@kit.ArkUI';
import { PhoneMessage } from './LoginByPhoneNumberStepOne';

@Entry
@Component
struct LoginByPhoneNumberStepTwo {
  @State areaNumber: string = ''; // 区号 (跳转过来时携带参数填充)
  @State phoneNumber: string = ''; // 手机号 (跳转过来时携带参数填充)
  @State phoneInputValue: string = '';
  @State passwordValue: string = '';
  @State loginByVerifyCode: boolean = true; // 是否用验证码登录
  @State verifyCode: string = ''; // 填写的验证码
  @State verifyCodeIsSending: boolean = false; // 验证码是否已发送, 倒计时期间为 true
  @State countdown: number = BusinessConstantValue.VERIFY_CODE_COUNTDOWN; // 倒计时
  private intervalId: number | null = null;
  // 验证码弹框
  dialogController: CustomDialogController = new CustomDialogController({
    builder: VerifyCodeDialog({
      phoneNumber: this.phoneInputValue,
      confirm: () => {
        this.sendVerifyCode()
      }
    }),
    autoCancel: true,
    customStyle: false,
    backgroundColor: $r('app.color.custom_dialog_bkg_color'),
    cornerRadius: UIConstantValue.BORDER_RADIUS_NUMBER_20,
    width: UIConstantValue.WIDTH_PERCENT_80,
    alignment: DialogAlignment.Center
  })

  aboutToAppear(): void {
    const params = router.getParams() as PhoneMessage;
    if (params) {
      this.phoneNumber = params.phoneNumber;
      this.areaNumber = params.areaNumber;
      this.phoneInputValue = this.areaNumber + this.phoneNumber;
    }
  }

  buttonClickable(): boolean {
    return this.phoneNumberIsRight() && this.passwordValueIsRight()
  }

  phoneNumberIsRight(): boolean {
    return this.phoneNumber !== ''
  }

  passwordValueIsRight(): boolean {
    return this.passwordValue !== ''
  }

  // 点击关闭
  onCloseButtonClicked() {
    router.replaceUrl({
      url: RouterUrlConstantValue.HOME_PAGE_URL
    })
  }

  // 点击登录
  onLoginButtonClicked() {

  }

  // 点击获取验证码
  onGetVerifyCodeClicked() {
    this.dialogController.open()
  }

  // 发送验证码
  sendVerifyCode() {
    cloud.auth().requestVerifyCode({
      action: VerifyCodeAction.REGISTER_LOGIN,
      lang: 'zh_CN',
      sendInterval: BusinessConstantValue.VERIFY_CODE_COUNTDOWN,
      verifyCodeType: {
        phoneNumber: this.phoneNumber,
        countryCode: this.areaNumber,
        kind: 'phone'
      }
    }).then(verifyCodeResult => {
      this.startCountdown()
      AlertDialog.show({ message: JSON.stringify(verifyCodeResult, null, 2) })
    }).catch((error: BusinessError) => {
      AlertDialog.show({ message: JSON.stringify(error, null, 2) })
    })
  }

  // 开启倒计时
  startCountdown() {
    if (this.intervalId) {
      return; // 定时器已经存在, 不重复启动
    }
    this.countdown = BusinessConstantValue.VERIFY_CODE_COUNTDOWN;
    this.verifyCodeIsSending = true;
    this.intervalId = setInterval(() => {
      this.countdown--;
      if (this.countdown === 0) {
        this.verifyCodeIsSending = false;
      }
    }, BusinessConstantValue.TIMER_INTERVAL_1000)
  }

  // 关闭定时器
  stopInterval() {
    if (this.intervalId) {
      clearInterval(this.intervalId)
      this.intervalId = null;
    }
  }

  aboutToDisappear(): void {
    this.stopInterval()
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
          placeholder: $r("app.string.login_phone_input_placeholder"),
          itemName: $r('app.string.login_phone'),
          inputBorderColor: $r('app.color.border_color'),
          itemValue: this.phoneInputValue,
          inputEnabled: false
        })
        if (this.loginByVerifyCode) {
          Stack() {
            ItemInput({
              placeholder: $r('app.string.verify_code_placeholder'),
              itemName: $r('app.string.verify_code'),
              inputBorderColor: $r('app.color.border_color'),
              itemValue: this.verifyCode,
              inputWidth: UIConstantValue.WIDTH_PERCENT_38
            })
            Button($r('app.string.get_verify_code'), { type: ButtonType.Normal })
              .visibility(this.verifyCodeIsSending ? Visibility.Hidden : Visibility.Visible)// 获取验证码按钮是否可见
              .fontSize(FontConstantValue.FONT_SIZE_14)
              .fontColor($r('app.color.get_verify_button_font_color'))
              .backgroundColor($r('app.color.get_verify_button_bkg_color'))
              .padding(UIConstantValue.PADDING_8)
              .height(UIConstantValue.HEIGHT_30)
              .borderRadius(UIConstantValue.BORDER_RADIUS_5)
              .offset({ x: UIConstantValue.OFFSET_PERCENT_30 })
              .onClick(() => {
                this.onGetVerifyCodeClicked();
              })
            // 获取验证码倒计时
            Text($r('app.string.get_verify_code_countdown', this.countdown))
              .visibility(this.verifyCodeIsSending ? Visibility.Visible : Visibility.Hidden)
              .fontColor($r('app.color.countdown_font_color'))
              .fontSize(FontConstantValue.FONT_SIZE_14)
              .offset({ x: UIConstantValue.OFFSET_PERCENT_30 })
          }
        } else {
          ItemInput({
            placeholder: $r('app.string.password_input_placeholder'),
            itemName: $r('app.string.password_input_name'),
            inputBorderColor: $r('app.color.border_color'),
            itemValue: this.passwordValue,
            inputType: InputType.Password
          })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .width(UIConstantValue.WIDTH_PERCENT_100)
      .margin({ top: UIConstantValue.MARGIN_PERCENT_7 })

      // 切换为密码登录
      ChangeLoginType({
        loginType: this.loginByVerifyCode ? $r('app.string.login_by_password') : $r('app.string.login_by_verify_code')
      }).margin({
        top: UIConstantValue.MARGIN_PERCENT_6
      }).onClick(() => {
        this.loginByVerifyCode = !this.loginByVerifyCode
      })

      // 登录按钮
      Row() {
        AgreeButton({
          buttonText: $r('app.string.login'),
          buttonClickable: this.buttonClickable()
        })
          .onClick(this.onLoginButtonClicked)
      }
      .width(UIConstantValue.WIDTH_PERCENT_100)
      .justifyContent(FlexAlign.Center)
      .margin({
        top: UIConstantValue.MARGIN_PERCENT_95
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

// 验证码弹框组件
@CustomDialog
struct VerifyCodeDialog {
  phoneNumber: string = '';
  controller: CustomDialogController = new CustomDialogController({
    builder: VerifyCodeDialog({}),
  })
  cancel?: () => void
  confirm?: () => void

  build() {
    Column({ space: UIConstantValue.SPACE_15 }) {
      Text($r('app.string.phone_number_confirm'))
        .fontColor($r('app.color.custom_dialog_title_font_color'))
        .fontWeight(FontWeight.Bold)
        .fontSize(FontConstantValue.FONT_SIZE_16)
      Column({ space: UIConstantValue.SPACE_5 }) {
        Text($r('app.string.verify_code_send_tip'))
          .fontColor($r('app.color.verify_code_send_tip_font_color'))
          .fontSize(FontConstantValue.FONT_SIZE_16)
        Text(this.phoneNumber)
      }

      Row() {
        Button($r('app.string.cancel'), { type: ButtonType.Normal })
          .width(UIConstantValue.WIDTH_PERCENT_50)
          .height(UIConstantValue.HEIGHT_60)
          .fontColor($r('app.color.custom_dialog_cancel_font_color'))
          .fontWeight(FontWeight.Bold)
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            this.controller.close()
            if (this.cancel) {
              this.cancel()
            }
          })
        Divider()
          .vertical(true)
          .color($r('app.color.login_page_divider_color'))
          .height(UIConstantValue.HEIGHT_60)
          .strokeWidth(UIConstantValue.WIDTH_1)
        Button($r('app.string.confirm'), { type: ButtonType.Normal })
          .width(UIConstantValue.WIDTH_PERCENT_50)
          .height(UIConstantValue.HEIGHT_60)
          .fontColor($r('app.color.custom_dialog_confirm_font_color'))
          .fontWeight(FontWeight.Bold)
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            this.controller.close()
            if (this.confirm) {
              this.confirm()
            }
          })
      }
      .border({
        width: {
          top: UIConstantValue.BORDER_WIDTH_1
        },
        color: $r('app.color.border_color')
      })
      .margin({
        top: UIConstantValue.MARGIN_10
      })
      .padding({
        left: UIConstantValue.PADDING_10,
        right: UIConstantValue.PADDING_10
      })
    }
    .padding({
      top: UIConstantValue.PADDING_30
    })
  }
}