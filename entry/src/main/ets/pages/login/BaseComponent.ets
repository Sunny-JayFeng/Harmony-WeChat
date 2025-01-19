import { FontConstantValue, UIConstantValue } from "constantvalue";

// 关闭图标
@Component
export struct CloseIcon {
  build() {
    Row() {
      Image($r('app.media.closeIcon'))
        .width(UIConstantValue.WIDTH_20)
        .height(UIConstantValue.HEIGHT_20)
    }
    .justifyContent(FlexAlign.Start)
  }
}

// 登录方式
@Component
export struct LoginTypeText {
  @Prop loginType: Resource;

  build() {
    Row() {
      Text(this.loginType)
        .fontSize(FontConstantValue.FONT_SIZE_18)
    }
    .justifyContent(FlexAlign.Center)
  }
}

// 改变登录方式
@Component
export struct ChangeLoginType {
  @Prop loginType: Resource;

  build() {
    Text(this.loginType)
      .fontSize(FontConstantValue.FONT_SIZE_16)
      .fontColor($r("app.color.change_login_type_button_color"))
  }
}

// 信息提示
@Component
export struct StatementTip {
  @Prop statementTip: Resource;

  build() {
    Text(this.statementTip)
      .fontSize(FontConstantValue.FONT_SIZE_12)
      .fontColor($r('app.color.login_statement_font_color'))
  }
}

// 按钮
@Component
export struct AgreeButton {
  @Prop buttonText: Resource
  @Prop buttonClickable: boolean = false;

  build() {
    Button(this.buttonText, { type: ButtonType.Normal })
      .width(UIConstantValue.WIDTH_PERCENT_50)
      .height(UIConstantValue.HEIGHT_45)
      .borderRadius(UIConstantValue.BORDER_RADIUS_5)
      .fontSize(FontConstantValue.FONT_SIZE_14)
      .fontColor(this.buttonClickable ? Color.White : $r('app.color.login_button_font_color'))
      .backgroundColor(this.buttonClickable ? $r('app.color.login_page_clickable_button_color') :
      $r('app.color.login_page_button_color'))
  }
}

// 找回密码等其他操作
@Component
export struct SelfHelpText {
  @Prop text: Resource;
  @Prop hasDivider: boolean = false;
  onTextClick: () => void = () => {
  };

  build() {
    Row({ space: UIConstantValue.SPACE_8 }) {
      Text(this.text)
        .fontSize(FontConstantValue.FONT_SIZE_12)
        .fontColor($r("app.color.change_login_type_button_color"))
        .onClick(this.onTextClick)
      if (this.hasDivider) {
        Divider()
          .vertical(true)
          .color($r('app.color.login_page_divider_color'))
          .height(UIConstantValue.HEIGHT_18)
          .strokeWidth(UIConstantValue.WIDTH_1)
      }
    }
  }
}