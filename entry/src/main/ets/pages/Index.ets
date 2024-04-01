import { CommonConstants } from '../common/constants/CommonConstants'
import Home from '../view/home/Home'

@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  @State isPageShow: boolean = false

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        Text('首页')
      }.tabBar(this.TabBarBuilder($r('app.string.main_page'), $r('app.media.home'), 0))

      TabContent() {
        Text('社区')
      }.tabBar(this.TabBarBuilder($r('app.string.community'), $r('app.media.community'), 1))

      TabContent() {
        Text('发现')
      }.tabBar(this.TabBarBuilder($r('app.string.explore'), $r('app.media.explore'), 2))

      TabContent() {
        Text('消息')
      }.tabBar(this.TabBarBuilder($r('app.string.message'), $r('app.media.message'), 3))

      TabContent() {
        Home()
      }.tabBar(this.TabBarBuilder($r('app.string.me'), $r('app.media.me'), 4))

    }
    .width('100%')
    .height('100%')
    .onChange(index => {
      this.currentIndex = index
    })
  }

  @Builder
  TabBarBuilder(title: ResourceStr, image: ResourceStr, index: number) {
    Column({ space: CommonConstants.SPACE_8 }) {
      Image(image).width(22).fillColor(this.selectColor(index))
      Text(title).fontSize(14).fontColor(this.selectColor(index))
    }
  }

  selectColor(index: number) {
    return this.currentIndex === index ? $r('app.color.primary_blue') : $r('app.color.gray')
  }
}