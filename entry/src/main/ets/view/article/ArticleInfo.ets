import axios from '@ohos/axios';
import { CommonConstants } from '../../common/constants/CommonConstants';

@Component
export default struct ArticleInfo {
  @Link articleId: number
  @State articleTitle: string = ''
  @State content: string = ''
  @State coverImg: string = ''
  @State categoryId: number = 0
  @State categoryName: string = ''
  @State authorId: string = ''
  @State createTime: string = ''
  @Link likeNum: number
  @Link commentNum: number
  @Link collectNum: number
  @State nickname: string = ''
  @State sex: number = 1
  @State userPic: string = ''
  @State email: string = ''

  aboutToAppear() {

    axios(CommonConstants.BASE_URL + `/articles/${this.articleId}`, {
      headers: {
        'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGFpbXMiOnsidXNlcm5hbWUiOiIzMjAwNjIxMDE3In0sImV4cCI6MTcxMzQzOTc5OH0.wuzPAf4zyFphjK7gQXktAoeWyf-hHAbf3IeZkkWfAis',
      }
    })
      .then((response) => {
        let data = response.data.data
        let article = data.article
        let category = data.category
        let user = data.user

        this.articleId = article.articleId
        this.articleTitle = article.articleTitle
        this.content = article.content
        this.coverImg = article.coverImg
        this.categoryId = article.categoryId
        this.categoryName = category.categoryName
        this.authorId = article.authorId
        this.createTime = article.createTime.toString()
        this.likeNum = article.likeNum
        this.commentNum = article.commentNum
        this.collectNum = article.collectNum
        this.nickname = user.nickname
        this.sex = user.sex
        this.userPic = user.userPic
        this.email = user.email
      })
      .catch((err: Error) => {
        console.log("ERROR: " + err.message)
      })

  }

  build() {
    Stack() {

      Column() {
        //文章标题信息
        this.ArticleBaseInfo({
          articleTitle: this.articleTitle,
          categoryName: this.categoryName,
          userPic: this.userPic,
          nickname: this.nickname,
          createTime: this.createTime
        })
        Divider()

        Scroll() {
          // 文章正文信息
          Text(this.content)
            .fontSize(18)
        }
        .padding({ top: CommonConstants.SPACE_12, bottom: CommonConstants.DEFAULT_60 })
        .width(CommonConstants.THOUSANDTH_940)
        .layoutWeight(1)

      }
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  ArticleBaseInfo($$: {
    articleTitle: string
    categoryName: string
    userPic: string
    nickname: string
    createTime: string
  }) {
    Column() {
      // 文章标题
      Text($$.articleTitle).fontSize(22).fontWeight(FontWeight.Bold)
      Row() {
        Row({ space: CommonConstants.SPACE_10 }) {
          Image($$.userPic).height(20).borderRadius(10)

          //作者
          Text($$.nickname)
        }

        //发布时间
        Text($$.createTime.substring(0, 10))

        //文章归类
        Text($$.categoryName)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .padding({ top: CommonConstants.SPACE_10, bottom: CommonConstants.SPACE_10 })
    .backgroundColor($r('app.color.white_silver'))
    .backgroundColor(Color.White)
    .width(CommonConstants.THOUSANDTH_940)

  }
}