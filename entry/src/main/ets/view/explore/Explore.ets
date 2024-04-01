import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'
import HomeHeader from '../../conponent/HomeHeader'

@Component
export default struct Explore {
  build() {
    Column({ space: CommonConstants.SPACE_10 }) {
      HomeHeader({ isBack: false, title: '发现', headerBackgroundColor: $r('app.color.green_badminton') })

      this.ItemCard({
        image: $r("app.media.bwf_logo"),
        name: '羽联排名',
        explain: '各项积分排名榜',
        routerPage: 'pages/explore/Rank'
      })

      this.ItemCard({
        image: $r("app.media.calendar"),
        name: '赛事日历',
        explain: '2024年赛事',
        routerPage: 'pages/explore/EventCalendar'
      })

      this.ItemCard({
        image: $r("app.media.contest"),
        name: '计分工具',
        explain: '个人比赛计分工具',
        routerPage: 'pages/Index'
      })

    }.width('100%')
    .height('100%')
  }

  @Builder
  ItemCard($$: {
    image: ResourceStr,
    name: ResourceStr
    explain?: ResourceStr,
    routerPage: string,
  }) {
    Row() {
      Row({ space: CommonConstants.SPACE_10 }) {
        Image($$.image).height(20)
        Text($$.name).fontSize(CommonConstants.DEFAULT_18).fontWeight(CommonConstants.FONT_WEIGHT_600)
        Blank()
        if ($$.explain) {
          Text($$.explain)
        }
        Image($r('app.media.right')).height(20)
      }
      .padding({
        left: 20
      })
      .height(CommonConstants.DEFAULT_48)
      .width(CommonConstants.THOUSANDTH_940)
    }
    .onClick(() => {
      router.pushUrl({
        url: $$.routerPage
      })
    })
    .backgroundColor($r('app.color.white_cloud'))
    .width('100%')
  }
}