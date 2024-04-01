import { CommonConstants } from '../common/constants/CommonConstants'
import LoginRegisterHeader from '../conponent/LoginRegisterHeader'
import LoginBody from '../view/login/LoginBody'

@Entry
@Component
struct Login {
  @State username: string = ''
  @State password: string = ''
  @State isCheck: boolean = false

  build() {
    Column() {
      LoginRegisterHeader({ title: $r('app.string.Login_Title') })
      Column({ space: CommonConstants.SPACE_10 }) {
        Text('账号密码登录').fontWeight(CommonConstants.FONT_WEIGHT_700)
          .fontSize(32)

        LoginBody({ username: this.username, password: this.password, isCheck: this.isCheck })

        Text('忘记密码')
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}