import ItemInput from '../register/RegisterPage'
import { AgreeButton, ChangeLoginType, CloseIcon, LoginTypeText, SelfHelpText, StatementTip } from './BaseComponent'
import { router } from '@kit.ArkUI';
import { RequestURIConstantValue, RouterUrlConstantValue, UIConstantValue } from 'constantvalue';
import { request } from '../../request/request';
import { ResponseUserData } from '../../type/responseDataTypes/responseDataTypes';
import { AxiosError } from '@ohos/axios';
import dataPreferences from '@ohos.data.preferences'
import { User } from '../../type/serviceDataTypes/serviceDataTypes';

@Entry
@Component
struct LoginByAccount {
  @State accountValue: string = '';
  @State passwordValue: string = '';

  buttonClickable(): boolean {
    return this.accountFormatIsRight() && this.passwordFormatIsRight()
  }

  accountFormatIsRight(): boolean {
    return this.accountValue !== ''
  }

  passwordFormatIsRight(): boolean {
    return this.passwordValue !== ''
  }

  // 点击关闭
  onCloseButtonClicked() {
    router.replaceUrl({
      url: RouterUrlConstantValue.HOME_PAGE_URL
    })
  }

  // 切换为用手机号登录
  onChangeLoginTypeClicked() {
    router.replaceUrl({
      url: RouterUrlConstantValue.LOGIN_BY_PHONE_NUMBER_STEP_ONE
    })
  }

  // 点击同意并登录
  onLoginButtonClicked() {
    request.post<ResponseUserData, ResponseUserData>(RequestURIConstantValue.REQUEST_LOGIN_BY_ACCOUNT_AND_PASSWORD, {
      account: this.accountValue,
      password: this.passwordValue
    })
      .then((responseData: ResponseUserData) => {
        let responseUser: User = responseData.user
        if (responseData.requestSuccess && responseUser) {
          // 登录成功, 持久化 id 到本地
          let options: dataPreferences.Options = { name: 'userID' }
          let preferences: dataPreferences.Preferences = dataPreferences.getPreferencesSync(getContext(), options);
          preferences.putSync('currentUserID', responseUser.id)
          preferences.flush();
          // 跳转到主页
          router.replaceUrl({
            url: RouterUrlConstantValue.MAIN_PAGE
          })
          return;
        }
        // 账号不存在
        if (responseData.failCode === 1) {
          AlertDialog.show({ message: $r('app.string.account_not_exist') })
          return;
        }
        // 密码错误
        if (responseData.failCode === 2) {
          AlertDialog.show({ message: $r('app.string.password_error') })
          return;
        }
        // 打印日志信息
        AlertDialog.show({ message: JSON.stringify(responseData, null, 2) })
      })
      .catch((error: AxiosError) => {
        AlertDialog.show({ message: JSON.stringify(error, null, 2) })
      })
  }

  build() {
    Column() {
      // 关闭按钮
      CloseIcon()
        .onClick(this.onCloseButtonClicked)
      // 登录类型文本
      Row() {
        LoginTypeText({
          loginType: $r('app.string.account_login')
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
      .width(UIConstantValue.WIDTH_PERCENT_100)
      .margin({ top: UIConstantValue.MARGIN_PERCENT_7 })

      // 切换为手机号登录
      ChangeLoginType({
        loginType: $r('app.string.login_by_phone_number')
      }).margin({
        top: UIConstantValue.MARGIN_PERCENT_6
      }).onClick(this.onChangeLoginTypeClicked)

      // 隐私提示
      Row() {
        StatementTip({
          statementTip: $r('app.string.account_login_statement')
        }).margin({ top: UIConstantValue.MARGIN_PERCENT_90 })
      }
      .width(UIConstantValue.WIDTH_PERCENT_100)
      .justifyContent(FlexAlign.Center)

      // 同意并登录按钮
      Row() {
        AgreeButton({
          buttonText: $r("app.string.agree_and_login"),
          buttonClickable: this.buttonClickable()
        }).onClick(() => {
          if (this.buttonClickable()) {
            this.onLoginButtonClicked()
          }
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
          text: $r('app.string.emergency_freezing'),
          hasDivider: true,
          onTextClick: (): void => {
            AlertDialog.show({ message: '跳转到紧急页面' })
          }
        })
        SelfHelpText({
          text: $r('app.string.security_center'),
          onTextClick: (): void => {
            AlertDialog.show({ message: '跳转到安全中心页面' })
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