import { CommonConstants } from '../../common/constants/CommonConstants'

@CustomDialog
export default struct NullUsernamePassword {
  controller: CustomDialogController

  build() {
    Column({ space: CommonConstants.SPACE_10 }) {
      Text('提示').fontWeight(CommonConstants.FONT_WEIGHT_700).fontSize(20)

      Text('用户名或密码不能为空')

      Button('确定')
        .width(100).backgroundColor('#02bd79')
        .onClick(() => {
          this.controller.close()
        })
    }
    .width('100%')
    .padding(10)
  }
}
