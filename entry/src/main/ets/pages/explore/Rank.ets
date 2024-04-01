import BwfFinalsRank from '../../view/explore/rank/BwfFinalsRank'
import OlympicRank from '../../view/explore/rank/OlympicRank'
import WorldRank from '../../view/explore/rank/WorldRank'
import YouthRank from '../../view/explore/rank/YouthRank'

@Entry
@Component
struct Rank {
  build() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        WorldRank()
      }
      .tabBar('世界排名')

      TabContent() {
        OlympicRank()
      }
      .tabBar('奥运积分')

      TabContent() {
        BwfFinalsRank()
      }
      .tabBar('总决赛榜')

      TabContent() {
        YouthRank()
      }
      .tabBar('青年排名')
    }
    .width('100%')
    .height('100%')
  }
}