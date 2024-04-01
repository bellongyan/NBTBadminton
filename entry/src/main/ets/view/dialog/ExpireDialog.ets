import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'

@Preview
@CustomDialog
export default struct ExpireDialog {
  controller: CustomDialogController

  build() {
    Column({ space: CommonConstants.SPACE_10 }) {
      Text('提示').fontWeight(CommonConstants.FONT_WEIGHT_700).fontSize(20)

      Text('登录信息已过期，请重新登录')

      Button('确定')
        .width(100).backgroundColor('#02bd79')
        .onClick(() => {
          this.controller.close()
          router.clear()
          router.replaceUrl({
            url: 'pages/Login'
          })
        })
    }
    .width('100%')
    .padding(10)
  }
}