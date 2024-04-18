import LoginRegisterHeader from '../../conponent/LoginRegisterHeader'
import RegisterBody from '../../view/register/RegisterBody'

@Entry
@Component
struct Register {
  @State isCheck: boolean = false

  build() {
    Column() {
      LoginRegisterHeader({ title: $r('app.string.Register_Title') })

      Column() {
        RegisterBody({ isCheck: this.isCheck })
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