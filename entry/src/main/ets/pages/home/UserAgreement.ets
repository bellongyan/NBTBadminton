import { CommonConstants } from '../../common/constants/CommonConstants'
import LoginRegisterHeader from '../../conponent/LoginRegisterHeader'

@Extend(Text)
function contentSytle() {
  .fontSize(18).width(CommonConstants.THOUSANDTH_940)
}

@Entry
@Component
struct UserAgreement {
  build() {
    Column() {
      //   顶部标题
      LoginRegisterHeader({ title: $r('app.string.User_Agreement_Title') })

      Scroll() {
        //   正文
        Text($r('app.string.User_Agreement')).contentSytle()
      }.layoutWeight(1)

    }
    .width(CommonConstants.THOUSANDTH_1000)
    .height(CommonConstants.THOUSANDTH_1000)
  }
}