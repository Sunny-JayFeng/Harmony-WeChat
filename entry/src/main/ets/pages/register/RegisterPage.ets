import { router } from '@kit.ArkUI';
import { FontConstantValue, RouterUrlConstantValue, UIConstantValue } from 'constantvalue';

@Entry
@Component
struct RegisterPage {
  @Provide('weChatName') weChatName: string = '';
  @Provide('phoneNumber') phoneNumber: string = '';
  @Provide('password') password: string = '';
  @Provide('agreeAgreement') agreeAgreement: boolean = false;

  buttonClickable(): boolean {
    return this.weChatNameIsRight() && this.phoneNumberIsRight() && this.passwordIsRight() && this.agreeAgreement;
  }

  weChatNameIsRight(): boolean {
    return this.weChatName !== ''
  }

  phoneNumberIsRight(): boolean {
    return this.phoneNumber !== '' // 按需校验手机号规则
  }

  passwordIsRight(): boolean {
    return this.password !== ''
  }

  // 关闭页面
  onCloseButtonClicked() {
    router.replaceUrl({
      url: RouterUrlConstantValue.HOME_PAGE_URL
    })
  }

  // 头像选择
  onAvatarSelectorClicked() {

  }

  // 暂不支持国家/地区选择

  // 处理注册
  onRegisterButtonClicked() {
    if (!this.buttonClickable()) { // 再次校验
      return
    }
  }

  build() {
    Column() {
      // 关闭图标
      Row() {
        Image($r('app.media.closeIcon'))
          .width(UIConstantValue.WIDTH_20)
          .height(UIConstantValue.HEIGHT_20)
      }
      .width(UIConstantValue.WIDTH_PERCENT_100)
      .justifyContent(FlexAlign.Start)
      .onClick(this.onCloseButtonClicked)

      // 手机号注册
      Row() {
        Text($r('app.string.register_by_phone'))
          .fontSize(FontConstantValue.FONT_SIZE_20)
      }.margin({
        top: UIConstantValue.MARGIN_PERCENT_15
      })

      // 头像文件选择器
      ImageSelector()
        .margin({
          top: UIConstantValue.MARGIN_PERCENT_8
        })
        .onClick(this.onAvatarSelectorClicked)

      // 输入组件
      InputItemsWrapper()
        .margin({
          top: UIConstantValue.MARGIN_PERCENT_12
        })

      // 隐私协议组件
      Agreement()
        .margin({
          top: UIConstantValue.MARGIN_PERCENT_50
        })

      Button($r("app.string.agree_and_continue"), { type: ButtonType.Normal })
        .width(UIConstantValue.WIDTH_PERCENT_50)
        .height(UIConstantValue.HEIGHT_PERCENT_5)
        .borderRadius(UIConstantValue.BORDER_RADIUS_5)
        .fontSize(FontConstantValue.FONT_SIZE_14)
        .fontColor(this.buttonClickable() ? Color.White : $r('app.color.agree_register_button_font_color'))
        .backgroundColor(this.buttonClickable() ? $r('app.color.agree_register_clickable_button_color') :
        $r('app.color.agree_register_button_color'))
        .margin({
          top: UIConstantValue.MARGIN_PERCENT_6
        })
        .onClick(this.onRegisterButtonClicked)

    }
    .padding({
      left: UIConstantValue.PADDING_PERCENT_10,
      top: UIConstantValue.PADDING_PERCENT_5,
      right: UIConstantValue.PADDING_PERCENT_10
    })
    .height(UIConstantValue.WIDTH_PERCENT_100)
    .width(UIConstantValue.HEIGHT_PERCENT_100)
  }
}

@Component
struct ImageSelector {
  build() {
    Stack() {
      Row()
        .width(UIConstantValue.WIDTH_65)
        .height(UIConstantValue.HEIGHT_65)
        .backgroundColor($r('app.color.register_avatar_selector_bkg_color'))
      Image($r('app.media.registerCameraIcon'))
        .width(UIConstantValue.WIDTH_20)
        .height(UIConstantValue.HEIGHT_20)
        .objectFit(ImageFit.Contain)
        .offset({ x: UIConstantValue.OFFSET_NEGATIVE_22, y: UIConstantValue.OFFSET_NEGATIVE_22 })
      Row()
        .width(UIConstantValue.WIDTH_10)
        .height(UIConstantValue.HEIGHT_10)
        .linearGradient({
          direction: GradientDirection.RightBottom,
          repeating: false,
          colors: [[Color.Transparent, 0.5], [0xaaaaaa, 0.5]]
        })
        .offset({ x: UIConstantValue.OFFSET_NEGATIVE_0_5 })
      Row()
        .width(UIConstantValue.WIDTH_15)
        .height(UIConstantValue.HEIGHT_15)
        .border({
          width: UIConstantValue.BORDER_WIDTH_2,
          color: $r('app.color.register_bkg_color')
        })
        .rotate({
          angle: UIConstantValue.ROTATE_ANGLE_45
        })
        .offset({ x: UIConstantValue.OFFSET_7, y: UIConstantValue.OFFSET_7 })
    }
    .alignContent(Alignment.BottomEnd)
  }
}

// 注册信息填写组件
@Component
struct InputItemsWrapper {
  @Consume('weChatName') weChatName: string;
  @Consume('phoneNumber') phoneNumber: string;
  @Consume('password') password: string;
  @State private area: string = '中国大陆 (+86)'

  build() {
    Column() {
      ItemInput({
        placeholder: $r('app.string.register_name_input_placeholder'),
        itemName: $r('app.string.register_name_input'),
        itemValue: this.weChatName
      });
      ItemInput({
        placeholder: $r('app.string.register_area_select_placeholder'),
        itemName: $r('app.string.register_area_input'),
        itemValue: this.area,
        valueColor: $r('app.color.register_area_font_color'),
        inputEnabled: false
      })
      ItemInput({
        placeholder: $r('app.string.register_phone_input_placeholder'),
        itemName: $r('app.string.register_phone_input'),
        itemValue: this.phoneNumber
      });
      ItemInput({
        placeholder: $r('app.string.register_password_input_placeholder'),
        itemName: $r('app.string.register_password_input'),
        itemValue: this.password,
        inputType: InputType.Password
      })
    }
  }
}

// 单个输入组件
@Component
export default struct ItemInput {
  placeholder?: Resource;
  itemName?: Resource;
  @Link itemValue: string;
  valueColor?: ResourceColor;
  inputBorderColor?: ResourceColor;
  inputType?: InputType = InputType.Normal;
  inputEnabled?: boolean = true;
  inputWidth?: string = UIConstantValue.WIDTH_PERCENT_65;
  @State closeIconVisible: Visibility = Visibility.Hidden

  build() {
    Row() {
      Text(this.itemName)
        .fontSize(FontConstantValue.FONT_SIZE_14)
        .width(UIConstantValue.WIDTH_75)
      TextInput({ placeholder: this.placeholder, text: $$this.itemValue })
        .placeholderFont({
          size: FontConstantValue.FONT_SIZE_14
        })
        .enabled(this.inputEnabled)
        .placeholderColor($r("app.color.register_text_input_placeholder_color"))
        .backgroundColor(Color.Transparent)
        .fontColor(this.valueColor ? this.valueColor : $r('app.color.font_color'))
        .type(this.inputType)
        .width(this.inputWidth)
        .onChange((value: string) => {
          this.closeIconVisible = this.inputEnabled && value !== '' ? Visibility.Visible : Visibility.Hidden;
        })
        .padding({
          left: UIConstantValue.PADDING_0,
        })
      Image($r('app.media.inputClearIcon'))
        .width(UIConstantValue.WIDTH_25)
        .height(UIConstantValue.HEIGHT_25)
        .objectFit(ImageFit.Contain)
        .visibility(this.closeIconVisible)
        .onClick(() => {
          this.itemValue = '';
        })
    }
    .border({
      width: {
        bottom: UIConstantValue.BORDER_WIDTH_1_POINT_5
      },
      color: this.inputBorderColor ? this.inputBorderColor : $r('app.color.register_text_input_border_color')
    })
    .width(UIConstantValue.WIDTH_PERCENT_100)
    .padding({
      left: UIConstantValue.PADDING_5,
      top: UIConstantValue.PADDING_10,
      right: UIConstantValue.PADDING_15,
      bottom: UIConstantValue.PADDING_5
    })
  }
}

// 隐私协议 UI 组件
@Component
struct Agreement {
  @Consume('agreeAgreement') agreeAgreement: boolean;

  build() {
    Column() {
      Row() {
        Radio({ value: '', group: '' })
          .size({ width: UIConstantValue.WIDTH_18, height: UIConstantValue.HEIGHT_18 })
          .checked(this.agreeAgreement)
          .onClick(() => {
            this.agreeAgreement = !this.agreeAgreement
          })
        Row() {
          Text($r('app.string.register_read_and_agree'))
            .fontSize(FontConstantValue.FONT_SIZE_12)
            .fontColor($r('app.color.register_agreement_font_color'))
          Text($r('app.string.app_agree_agreement'))
            .fontSize(FontConstantValue.FONT_SIZE_12)
            .fontColor($r('app.color.register_agreement_link_font_color'))
        }
      }

      Row() {
        Text($r('app.string.register_message_gather_tip'))
          .fontSize(FontConstantValue.FONT_SIZE_12)
          .fontColor($r('app.color.register_agreement_font_color'))
      }
    }
  }
}

