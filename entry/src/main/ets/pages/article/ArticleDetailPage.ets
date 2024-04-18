import router from '@ohos.router';
import HomeHeader from '../../conponent/HomeHeader'
import ArticleInfo from '../../view/article/ArticleInfo';
import EndInfo from '../../view/article/EndInfo';

@Entry
@Component
struct ArticleDetailPage {
  @State articleId: number = 1
  @State likeNum: number = 0
  @State commentNum: number = 0
  @State collectNum: number = 0
  scroller: Scroller = new Scroller()

  aboutToAppear() {
    this.articleId = router.getParams()['articleId']
  }

  build() {
    Column() {
      HomeHeader({ isBack: true, title: '文章详情', headerBackgroundColor: $r('app.color.primary_blue') })

      Column() {
        ArticleInfo({
          articleId: this.articleId,
          likeNum: this.likeNum,
          commentNum: this.commentNum,
          collectNum: this.collectNum
        })
      }
      .width('100%')
      .layoutWeight(1)

      Column() {
        Divider()
        EndInfo({ likeNum: this.likeNum, commentNum: this.commentNum, collectNum: this.collectNum })
      }
      .height(50)
      .width('100%')
    }
    .justifyContent(FlexAlign.Start)
    .width('100%')
    .height('100%')
  }
}