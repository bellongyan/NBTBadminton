import { CommonConstants } from '../../common/constants/CommonConstants'
import HomeHeader from '../../conponent/HomeHeader'
import CommentBody from '../../view/article/CommentBody'

@Entry
@Component
struct ArticleCommentPage {
  build() {
    Column({ space: CommonConstants.SPACE_10 }) {
      HomeHeader({ isBack: true, title: '评论区', headerBackgroundColor: $r('app.color.primary_blue') })

      CommentBody().layoutWeight(1).width(CommonConstants.THOUSANDTH_940).height('100%')

      Button("我也要发评论！")
        .type(ButtonType.Normal).width(200).margin({ bottom: 20 })
        .backgroundColor($r('app.color.light_primary_blue'))
    }
    .width('100%')
    .height('100%')
  }
}