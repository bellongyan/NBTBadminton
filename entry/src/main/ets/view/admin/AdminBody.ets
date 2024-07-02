import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'
import HomeHeader from '../../conponent/HomeHeader'

@Component
export default struct AdminBody {
  build() {
    Column({ space: CommonConstants.SPACE_10 }) {
      HomeHeader({ isBack: false, title: '系统管理', headerBackgroundColor: $r('app.color.green_badminton') })

      this.ItemCard({
        image: $r("app.media.userManager"),
        name: '用户管理',
        explain: '规范管理论坛用户',
        routerPage: 'pages/explore/Rank'
      })

      this.ItemCard({
        image: $r("app.media.articleManager"),
        name: '贴文管理',
        explain: '文明发帖，友好交流',
        routerPage: 'pages/explore/EventCalendar'
      })

      this.ItemCard({
        image: $r("app.media.noticeManager"),
        name: '公告管理',
        explain: '及时发布最新消息',
        routerPage: 'pages/explore/ScoreRecord'
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