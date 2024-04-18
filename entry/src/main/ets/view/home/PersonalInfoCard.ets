import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'

@Styles
function sexStyle() {
  .height(16)
}

@Component
export default struct PersonalInfoCard {
  @Prop isLogin: boolean
  @Prop avatarUrl: string
  @Prop nickname: string
  @Prop sex: number
  @Prop email: string

  build() {
    Row({ space: CommonConstants.SPACE_12 }) {

      if (this.isLogin === true) {

        Image(this.avatarUrl ? this.avatarUrl : $r('app.media.personal'))
          .height(100)
          .margin({ left: 10 })
          .borderRadius(15)

        Blank()

        Column({ space: CommonConstants.SPACE_8 }) {
          Row({ space: CommonConstants.SPACE_8 }) {
            Text(this.nickname ? this.nickname : '用户名')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)

            if (this.sex === 0) {
              Image($r('app.media.woman')).sexStyle()
            } else {
              Image($r('app.media.man')).sexStyle()
            }
          }

          Text(this.email ? this.email : 'nbtbadminton@example.com')
            .fontSize(14)
        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.SpaceEvenly)

        Blank()
      }
      else {
        Column() {
          Text('您暂未登录，请先点击此处登录').fontSize(20)
        }
        .onClick(() => {
          router.pushUrl({
            url: 'pages/home/Login'
          })
        })
        .justifyContent(FlexAlign.Center)
        .height('100%')
        .width('100%')
      }
    }
    .borderRadius(20)
    .backgroundColor('#ecf0f1')
    .width(CommonConstants.THOUSANDTH_940)
    .height(120)
  }
}