import router from '@ohos.router';
import axios from '@ohos/axios';
import { CommonConstants } from '../../common/constants/CommonConstants';
import PreferenceUtil from '../../common/utils/PreferenceUtil';
import HomeHeader from '../../conponent/HomeHeader'
import Article from '../../viewmodel/Article';

const JWT_KEY = 'userJwtKey'

@Entry
@Component
struct CategoryArticlesPage {
  @State categoryName: string = ''
  @State categoryId: number = 1
  @State articleList: Article[] = []
  @State pageNum: number = 1
  @State isLoading: boolean = false
  @State jwt: string = ''

  async aboutToAppear() {
    let params = router.getParams();
    this.categoryName = params['categoryName']
    this.categoryId = params['categoryId']
    let jwt_data = await PreferenceUtil.getPreferenceValue('JwtPref', JWT_KEY, null)
    this.jwt = jwt_data.toString()

    console.log(this.categoryName)

    axios('http://192.168.43.177:8080/articles', {
      headers: {
        Authorization: this.jwt,
      },
      params: {
        pageNum: this.pageNum,
        pageSize: 10,
        categoryId: this.categoryId
      }
    }).then((response) => {
      let articleData = JSON.parse(JSON.stringify(response.data.data.items))
      this.articleList = articleData
    }).catch((error) => {
      console.log(error);
    });
  }

  build() {
    Column() {
      HomeHeader({ isBack: true, title: this.categoryName, headerBackgroundColor: $r('app.color.green_badminton') })

      List({ space: CommonConstants.SPACE_10 }) {
        ForEach(this.articleList, (item: Article) => {
          ListItem() {
            this.articleCard({
              articleId: item.articleId,
              articleTitle: item.articleTitle,
              content: item.content,
              coverImg: item.coverImg,
              categoryId: item.categoryId,
              authorId: item.authorId,
              createTime: item.createTime,
              likeNum: item.likeNum,
              commentNum: item.commentNum,
              collectNum: item.collectNum
            })
          }
          .onClick(() => {
            router.pushUrl({
              url: 'pages/article/ArticleDetailPage',
              params: {
                articleId: item.articleId
              }
            })
          })
        })
      }
      .height('100%')
      .width(CommonConstants.THOUSANDTH_940)
      .margin({ top: 20, bottom: 10 })
      .onReachEnd(() => {
        console.log('触底了')
        if (!this.isLoading) {
          this.isLoading = true
          console.log('加载数据')
          axios('http://192.168.43.177:8080/articles', {
            headers: {
              Authorization: this.jwt,
            },
            params: {
              pageNum: ++this.pageNum,
              pageSize: 10,
              categoryId: this.categoryId
            }
          }).then((response) => {
            let articleData = JSON.parse(JSON.stringify(response.data.data.items))
            this.articleList = this.articleList.concat(articleData)
            this.isLoading = false
          }).catch((error) => {
            console.log(error);
          });
        }
      })
      .layoutWeight(1)

      Button("我也要写贴文")
        .type(ButtonType.Normal)
        .width(200)
        .backgroundColor($r('app.color.middle_blue'))
        .margin({ bottom: 10 })
        .onClick(() => {
          router.pushUrl({
            url: "pages/article/ArticleEditPage"
          })
        })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  articleCard($$: {
    articleId: number
    articleTitle: string
    content: string
    coverImg: string
    categoryId: number
    authorId: number
    createTime: string
    likeNum: number
    commentNum: number
    collectNum: number
  }) {
    Column() {
      Row({ space: CommonConstants.SPACE_6 }) {
        Image($$.coverImg)
          .autoResize(true)
          .height(80)
          .width(80)
          .borderRadius(10)

        Column({ space: CommonConstants.SPACE_6 }) {
          //   标题
          Text($$.articleTitle)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .fontWeight(FontWeight.Bold)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')
          //   内容摘要
          Text($$.content)
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')
          //   其他信息
          Row({ space: CommonConstants.SPACE_12 }) {
            //   点赞
            Row() {
              Image($r('app.media.like')).height(20).fillColor(Color.Red)
              Text($$.likeNum.toString())
            }

            //   评论
            Row() {
              Image($r('app.media.comment')).height(20)
              Text($$.likeNum.toString())
            }

            //   收藏
            Row() {
              Image($r('app.media.collect')).height(20).fillColor(Color.Orange)
              Text($$.likeNum.toString())
            }
          }
          .width('100%')
        }
        .layoutWeight(1)
        .width('100%')
      }
      .padding({ left: 10, right: 10 })
      .height('100%')
      .width('100%')
    }
    .backgroundColor('#f4f4f4')
    .width('100%')
    .height(100)
    .borderRadius(10)
  }
}