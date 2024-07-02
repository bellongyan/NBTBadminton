import HomeHeader from '../../conponent/HomeHeader'
import HotArticles from './HotArticles'
import News from './News'

@Component
export default struct MainTabs {
  build() {
    Column() {
      HomeHeader({ isBack: false, title: '首页', headerBackgroundColor: $r('app.color.green_badminton') })

      Tabs({index:1}) {
        TabContent() {
          News()
        }.tabBar('资讯')

        TabContent() {
          HotArticles({tag: 'all'})
        }.tabBar('好文')

        TabContent() {
          HotArticles({tag: '24'})
        }.tabBar('24小时热帖')

        TabContent() {
          HotArticles({tag: '7'})
        }.tabBar('一周热帖')

        TabContent() {
          HotArticles({tag: '1'})
        }.tabBar('本月热帖')
      }
      .barMode(BarMode.Scrollable)
    }
    .width('100%')
    .height('100%')
  }
}
