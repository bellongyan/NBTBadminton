import { CommonConstants } from '../../../common/constants/CommonConstants'
import HomeHeader from '../../../conponent/HomeHeader'

@Extend(Button)
function contentSelectButton() {
  .type(ButtonType.Normal)
  .backgroundColor($r('app.color.light_purple'))
  .fontColor($r('app.color.purple'))
  .fontSize(14)
  .height(30)
  .width('18%')
}

@Component
export default struct BwfFinalsRank {
  build() {
    Column({ space: CommonConstants.SPACE_4 }) {
      HomeHeader({ isBack: true, title: '总决赛积分排名', headerBackgroundColor: $r('app.color.purple') })

      Row({ space: CommonConstants.SPACE_6 }) {
        Button($r('app.string.man_single')).contentSelectButton()
        Button($r('app.string.woman_single')).contentSelectButton()
        Button($r('app.string.man_double')).contentSelectButton()
        Button($r('app.string.women_double')).contentSelectButton()
        Button($r('app.string.mixed_doubles')).contentSelectButton()
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')

      List() {
        ForEach([1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3, 4, 5, 6, 7, 8, 0], item => {
          ListItem() {
            Column() {
              Text(item.toString())
            }
          }
        })
      }.width('100%')
      .height('100%')
      .layoutWeight(1)

      //   数据
    }
    .width('100%')
    .height('100%')
  }
}