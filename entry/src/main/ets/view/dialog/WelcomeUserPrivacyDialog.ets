import { CommonConstants } from '../../common/constants/CommonConstants'

@Preview
@CustomDialog
export default struct WelcomeUserPrivacyDialog {
  controller: CustomDialogController
  confirm: () => void
  cancel: () => void

  build() {
    Column({ space: CommonConstants.SPACE_10 }) {
      // 标题
      Text($r('app.string.User_Privacy_Title'))
        .fontSize(20).fontWeight(CommonConstants.FONT_WEIGHT_700)

      // 正文
      Text($r('app.string.User_Privacy_Content'))

      // 按钮
      Button($r('app.string.Agree_Label'))
        .width(150).backgroundColor($r('app.color.primary_blue'))
        .onClick(() => {
          this.confirm()
          this.controller.close()
        })

      Button($r('app.string.Cancel_Label'))
        .width(150).fontColor($r('app.color.light_dark'))
        .backgroundColor($r('app.color.light_primary_blue'))
        .onClick(() => {
          this.cancel()
          this.controller.close()
        })
    }
    .width('100%')
    .padding(10)
  }
}