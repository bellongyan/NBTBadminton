import router from '@ohos.router'
import { CommonConstants } from '../common/constants/CommonConstants'

@Component
export default struct LoginRegisterHeader {
  title: ResourceStr

  build() {
    Column() {
      Row() {
        Image($r('app.media.back')).height(20).onClick(() => {
          router.back()
        })
        Blank()
        Text(this.title).fontSize(20).fontWeight(CommonConstants.FONT_WEIGHT_600)
        Blank()
        Image($r('app.media.back')).height(20).fillColor(Color.White)
      }
      .margin({
        top: CommonConstants.DEFAULT_20,
        bottom: CommonConstants.DEFAULT_10,
        left: CommonConstants.DEFAULT_10,
        right: CommonConstants.DEFAULT_10
      })
      .width(CommonConstants.THOUSANDTH_1000)

      Divider()
    }
  }
}