import axios from '@ohos/axios'
import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'
import HomeHeader from '../../conponent/HomeHeader'
import Article from '../../viewmodel/Article'
import PreferenceUtil from '../../common/utils/PreferenceUtil'
import Base64Util from '../../common/utils/Base64Util'
import UserInfo from '../../viewmodel/UserInfo'

const JWT_KEY = 'userJwtKey'

@Styles
function sexStyle() {
  .height(16)
}

@Entry
@Component
struct PersonalHomePage {
  @State categoryName: string = ''
  @State categoryId: number = 1
  @State articleList: Article[] = []
  @State pageNum: number = 1
  @State isLoading: boolean = false
  @State isToUp: boolean = false
  @State isLogin: boolean = true
  @State avatarUrl: string = ''
  @State nickname: string = ''
  @State sex: number = 1
  @State email: string = ''
  @State jwt: string = ""
  @State userid: string = ""

  async aboutToAppear() {
    let jwt_data = await PreferenceUtil.getPreferenceValue('JwtPref', JWT_KEY, null)
    this.jwt = jwt_data.toString()

    let userInfo = jwt_data.toString().split(".")[1]
    let decodeString: string = Base64Util.decode(userInfo)
    this.userid = decodeString.substring(23, decodeString.length - 21)

    axios(`http://192.168.43.177:8080/users/${this.userid}`, {
      headers: {
        Authorization: this.jwt
      },
    })
      .then((response) => {
        let data = JSON.parse(JSON.stringify(response.data.data))
        this.avatarUrl = data.userPic
        this.nickname = data.nickname
        this.sex = data.sex
        this.email = data.email
      })
      .catch((error) => {
        console.log(error);
      });


    axios('http://192.168.43.177:8080/articles/user/3200621017', {
      headers: {
        Authorization: this.jwt
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
      HomeHeader({ isBack: true, title: '我的主页', headerBackgroundColor: $r('app.color.primary_blue') })

      // 个人信息
      Row({ space: CommonConstants.SPACE_12 }) {
        Image(this.avatarUrl ? this.avatarUrl : $r('app.media.personal'))
          .height(60)
          .margin({ left: 10 })
          .borderRadius(15)

        Blank()

        Column({ space: CommonConstants.SPACE_8 }) {
          Row({ space: CommonConstants.SPACE_8 }) {
            Text(this.nickname ? this.nickname : '用户名')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)

            if (this.sex === 0) {
              Image($r('app.media.woman')).sexStyle()
            } else {
              Image($r('app.media.man')).sexStyle()
            }
          }

          Text(this.email ? this.email : 'nbtbadminton@example.com')
            .fontSize(14)
        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.SpaceEvenly)

        Blank()

      }
      .margin({ top: 10, bottom: 10 })
      .borderRadius(20)
      .backgroundColor('#ecf0f1')
      .width(CommonConstants.THOUSANDTH_900)
      .height(80)

      Text('我的帖子').fontSize(20)
      Divider()

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
          .swipeAction({ end: this.DeleteArticle(item.articleId, item.authorId) })
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
      .margin({ top: 20, bottom: 20 })
      .onReachStart(() => {
        console.log('触顶了')
        if (!this.isToUp) {
          this.isToUp = true
          console.log('加载数据')
          axios('http://192.168.43.177:8080/articles/user/3200621017', {
            headers: {
              Authorization: this.jwt
            },
            params: {
              pageNum: 1,
              pageSize: 10,
            }
          }).then((response) => {
            let articleData = JSON.parse(JSON.stringify(response.data.data.items))
            this.articleList = articleData
            this.isToUp = false
          }).catch((error) => {
            console.log(error);
          });
        }
      })
      .onReachEnd(() => {
        console.log('触底了')
        if (!this.isLoading) {
          this.isLoading = true
          console.log('加载数据')
          axios('http://192.168.43.177:8080/articles/user/3200621017', {
            headers: {
              Authorization: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGFpbXMiOnsidXNlcm5hbWUiOiIzMjAwNjIxMDE3In0sImV4cCI6MTcxNDAyMDQ1MH0.RSLgGjjFXcI0V2XrMlikRF4Ynh_JJrJi7b3X0p-1MB8'
            },
            params: {
              pageNum: ++this.pageNum,
              pageSize: 10,
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

    }
    .width('100%')
    .height('100%')
  }

  @Builder
  DeleteArticle(articleId, userId) {
    Button() {
      Image($r('app.media.delete')).width(20).fillColor(Color.White)
    }
    .onClick(() => {
      axios.delete('http://192.168.43.177:8080/articles', {
        headers: {
          'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGFpbXMiOnsidXNlcm5hbWUiOiIzMjAwNjIxMDE3In0sImV4cCI6MTcxNDAyMDQ1MH0.RSLgGjjFXcI0V2XrMlikRF4Ynh_JJrJi7b3X0p-1MB8'
        },
        params: {
          articleId: articleId,
          userId: userId
        }
      })
        .then(function (response) {
          console.log(JSON.stringify(response.data));
        })
        .catch(function (error) {
          console.log(error);
        });
    })
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
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