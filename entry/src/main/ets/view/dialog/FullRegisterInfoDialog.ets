import { CommonConstants } from '../../common/constants/CommonConstants'

@Preview
@CustomDialog
export default struct FullRegisterInfoDialog {
  controller: CustomDialogController

  build() {
    Column({ space: CommonConstants.SPACE_10 }) {
      Text($r('app.string.Prompt')).fontWeight(CommonConstants.FONT_WEIGHT_700).fontSize(20)

      Text($r('app.string.Registration_Prompt'))

      Button($r('app.string.Confirm'))
        .width(100).backgroundColor('#02bd79')
        .onClick(() => {
          this.controller.close()
        })
    }
    .padding(10)
    .width('100%')
  }
}