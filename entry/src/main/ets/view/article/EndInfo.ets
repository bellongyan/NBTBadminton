import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'

@Component
export default struct EndInfo {
  @Link likeNum: number
  @Link commentNum: number
  @Link collectNum: number

  build() {
    Column() {
      Row({ space: CommonConstants.SPACE_10 }) {

        Column() {
          Image($r('app.media.like')).height(20).fillColor(Color.Red)
          Text(this.likeNum.toString()).fontSize(12)
        }

        //收藏
        Column() {
          Image($r('app.media.collect')).height(20).fillColor(Color.Orange)
          Text(this.collectNum.toString()).fontSize(12)
        }

        //发送
        Button('打开评论区')
          .type(ButtonType.Normal)
          .onClick(() => router.pushUrl({
            url: 'pages/article/ArticleCommentPage',
            params: {
              articleId: 1 //TODO 修改此处id
            }
          }))
          .backgroundColor($r('app.color.primary_blue'))
          .height(35)
          .borderRadius(20)
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .height('100%')
      .width('100%')
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .height('100%')
    .width('100%')
  }
}