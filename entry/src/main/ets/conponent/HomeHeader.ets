import router from '@ohos.router'
import { CommonConstants } from '../common/constants/CommonConstants'

@Component
export default struct HomeHeader {
  isBack: boolean = false
  title: ResourceStr
  headerBackgroundColor: ResourceStr

  build() {

    Column() {
      Row({ space: CommonConstants.SPACE_10 }) {
        if (this.isBack === true) {
          Image($r('app.media.back')).height(20).onClick(() => {
            router.back()
          })
          Blank()
        }

        Text(this.title).fontSize(20).fontWeight(CommonConstants.FONT_WEIGHT_600)
          .fontColor($r('app.color.white_cloud'))


        if (this.isBack === true) {
          Blank()
          Image($r('app.media.back')).height(20).fillColor(this.headerBackgroundColor)
        }
      }.justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Bottom)
      .padding({
        top: CommonConstants.DEFAULT_16,
        bottom: CommonConstants.DEFAULT_10,
        left: CommonConstants.DEFAULT_10,
        right: CommonConstants.DEFAULT_10
      })
      .backgroundColor(this.headerBackgroundColor)
      .width(CommonConstants.THOUSANDTH_1000)


      Divider()
    }
  }
}