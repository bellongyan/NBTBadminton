import axios from '@ohos/axios'
import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'
import PreferenceUtil from '../../common/utils/PreferenceUtil'
import HomeHeader from '../../conponent/HomeHeader'
import PersonalInfoCard from './PersonalInfoCard'


const JWT_KEY = 'userJwtKey'

@Component
export default struct Home {
  @State isLogin: boolean = false
  @State avatarUrl: string = ''
  @State nickname: string = ''
  @State sex: number = 0
  @State email: string = ''

  async aboutToAppear() {
    let jwt_data = await PreferenceUtil.getPreferenceValue('JwtPref', JWT_KEY, null)
    var config = {
      method: 'get',
      url: 'http://192.168.43.177:8080/users/userInfo',
      headers: {
        'Authorization': jwt_data.toString(),
      }
    };
    axios(config)
      .then((response) => {
        this.isLogin = true
        let user = JSON.parse(JSON.stringify(response.data.data))
        this.nickname = user.nickname
        this.avatarUrl = user.userPic
        this.sex = user.sex
        this.email = user.email
      })
      .catch(function (error) {
        console.log(error);
      });
  }

  build() {
    Column({ space: CommonConstants.SPACE_10 }) {
      // 顶部
      HomeHeader({ isBack: false, title: $r('app.string.me'), headerBackgroundColor: $r('app.color.green_badminton') })

      // 用户信息
      // 如果登录显示信息，没登陆显示登录窗口
      PersonalInfoCard({
        isLogin: this.isLogin,
        avatarUrl: this.avatarUrl,
        nickname: this.nickname,
        sex: this.sex,
        email: this.email
      })


      // 主页
      this.FunctionList({
        image: $r('app.media.personal_home'),
        title: '个人主页',
        url: 'pages/home/PersonalHomePage'
      })

      // 帖子


      // 收藏夹
      this.FunctionList({
        image: $r('app.media.personal_collect'),
        title: '收藏夹',
        url: 'pages/home/CollectArticles'
      })


      this.FunctionList({
        image: $r('app.media.personal_like'),
        title: '喜欢的帖子',
        url: 'pages/home/LikeArticles'
      })


      // 设置
      this.FunctionList({
        image: $r('app.media.setting'),
        title: '设置',
        url: 'pages/Index'
      })

      // 退出账号
      Row({ space: CommonConstants.SPACE_12 }) {
        Image($r('app.media.exit')).height(30)
        Blank()
        Text('退出账号').fontSize(20)
      }
      .padding({ left: 20, right: 20 })
      .onClick(() => {
        this.isLogin = false
        PreferenceUtil.putPreferenceValue('JwtPref', JWT_KEY, null)
        router.pushUrl({
          url: 'pages/home/Login'
        })
      })
      .alignItems(VerticalAlign.Center)
      .borderRadius(10)
      .backgroundColor('#ecf0f1')
      .width(CommonConstants.THOUSANDTH_940)
      .height(50)

    }.width('100%')
    .height('100%')
  }

  @Builder
  FunctionList($$: {
    image: ResourceStr
    title: string
    url: string
  }) {
    Row({ space: CommonConstants.SPACE_12 }) {
      Image($$.image).height(30)
      Blank()
      Text($$.title).fontSize(20)
    }
    .padding({ left: 20, right: 20 })
    .onClick(() => {
      router.pushUrl({
        url: $$.url,
      })
    })
    .alignItems(VerticalAlign.Center)
    .borderRadius(10)
    .backgroundColor('#ecf0f1')
    .width(CommonConstants.THOUSANDTH_940)
    .height(50)
  }
}