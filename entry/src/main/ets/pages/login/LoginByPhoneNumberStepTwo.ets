import cloud, { SignInResult, VerifyCodeAction } from '@hw-agconnect/cloud';
import {
  BusinessConstantValue,
  FontConstantValue,
  RequestURIConstantValue,
  RouterUrlConstantValue,
  UIConstantValue
} from 'constantvalue';
import ItemInput from '../register/RegisterPage';
import { AgreeButton, ChangeLoginType, CloseIcon, LoginTypeText, SelfHelpText, StatementTip } from './BaseComponent';
import { BusinessError } from '@kit.BasicServicesKit';
import { router } from '@kit.ArkUI';
import { PhoneMessage } from './LoginByPhoneNumberStepOne';
import { request } from '../../request/request';
import { ResponseUserData } from '../../type/responseDataTypes/responseDataTypes';
import { AxiosError } from '@ohos/axios';
import { User } from '../../type/serviceDataTypes/serviceDataTypes';
import dataPreferences from '@ohos.data.preferences'

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
    if (this.loginByVerifyCode) {
      return this.phoneNumberFormatIsRight() && this.verifyCodeFormatIsRight()
    }
    return this.phoneNumberFormatIsRight() && this.passwordFormatIsRight()
  }

  phoneNumberFormatIsRight(): boolean {
    return this.phoneNumber != ''
  }

  verifyCodeFormatIsRight() {
    return this.verifyCode != '';
  }

  passwordFormatIsRight() {
    return this.passwordValue != ''
  }

  // 点击关闭
  onCloseButtonClicked() {
    router.replaceUrl({
      url: RouterUrlConstantValue.HOME_PAGE_URL
    })
  }

  // 点击登录
  onLoginButtonClicked() {
    // 验证码登录
    if (this.loginByVerifyCode) {
      cloud.auth().signIn({
        credentialInfo: {
          kind: 'phone',
          phoneNumber: this.phoneNumber,
          countryCode: this.areaNumber,
          verifyCode: this.verifyCode
        }
      })
        .then((result: SignInResult) => {
          // 验证码校验通过, 触发登录
          this.verifyCodeLogin();
        })
        .catch((error: BusinessError) => {
          if (error.code === 203818129) {
            AlertDialog.show({ message: $r('app.string.verification_code_is_incorrect') })
            return;
          }
          AlertDialog.show({ message: JSON.stringify(error, null, 2) })
        })
      return;
    }
    // 手机号密码登录
    this.passwordLogin();
  }

  verifyCodeLogin() {
    request.post<ResponseUserData, ResponseUserData>(RequestURIConstantValue.REQUEST_LOGIN_BY_PHONE_AND_VERIFY_CODE,
      this.phoneNumber)
      .then((responseData: ResponseUserData) => {
        let responseUser: User = responseData.user;
        if (responseData.requestSuccess && responseUser) {
          this.onLoginSuccess(responseUser);
          return;
        }
        // 失败
        if (responseData.failCode === 1) { // 账号不存在
          AlertDialog.show({ message: $r('app.string.account_not_exist') })
          return;
        }
        // 打印日志信息
        AlertDialog.show({ message: JSON.stringify(responseData, null, 2) })
      })
      .catch((error: AxiosError) => {
        // 打印错误日志
        AlertDialog.show({ message: JSON.stringify(error, null, 2) })
      })
  }

  passwordLogin() {
    request.post<ResponseUserData, ResponseUserData>(RequestURIConstantValue.REQUEST_LOGIN_BY_PHONE_AND_PASSWORD,
      {
        phoneNumber: this.phoneNumber,
        password: this.passwordValue
      })
      .then((responseData: ResponseUserData) => {
        let responseUser: User = responseData.user;
        if (responseData.requestSuccess && responseUser) {
          this.onLoginSuccess(responseUser)
          return;
        }
        // 请求参数错误
        if (responseData.failCode === 6) {
          AlertDialog.show({ message: $r('app.string.request_params_error') })
          return;
        }
        // 手机号未注册
        if (responseData.failCode === 7) {
          AlertDialog.show({ message: $r('app.string.phone_number_never_register') })
          return;
        }
        // 密码错误
        if (responseData.failCode === 2) {
          AlertDialog.show({ message: $r('app.string.password_error') })
          return;
        }
        // 其他错误, 打印错误日志
        AlertDialog.show({ message: JSON.stringify(responseData, null, 2) })
        return;
      })
      .catch((error: AxiosError) => {
        // 打印错误日志
        AlertDialog.show({ message: JSON.stringify(error, null, 2) })
      })
  }

  onLoginSuccess(responseUser: User) {
    // 登录成功
    // 登录后持久化 id 到本地, 后续不需要再登录
    let options: dataPreferences.Options = { name: 'userID' }
    let preferences: dataPreferences.Preferences = dataPreferences.getPreferencesSync(getContext(), options)
    preferences.putSync('currentUserID', responseUser.id)
    preferences.flush()
    router.replaceUrl({
      url: RouterUrlConstantValue.MAIN_PAGE
    })
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
      AlertDialog.show({ message: $r('app.string.verify_code_been_sent') })
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
        .onClick(() => {
          this.onCloseButtonClicked()
        })
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
          .onClick(() => {
            if (this.buttonClickable()) {
              // 只是为了校验验证码, 所以先退出登录(正常应该是自己写一套验证码系统)
              cloud.auth().signOut().then(() => {
                this.onLoginButtonClicked()
              })
            }
          })
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