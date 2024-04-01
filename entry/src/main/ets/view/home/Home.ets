import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'
import HomeHeader from '../../conponent/HomeHeader'

@Component
export default struct Home {
  build() {
    Column({ space: CommonConstants.SPACE_10 }) {
      // 顶部
      HomeHeader({ isBack: false, title: $r('app.string.me'), headerBackgroundColor: $r('app.color.green_badminton') })


      // 用户信息
      // 如果登录显示信息，没登陆显示登录窗口
      Button($r('app.string.Login_Title')).onClick(() => {
        router.pushUrl({
          url: 'pages/Login'
        })
      })


      // 主页


      // 帖子


      // 收藏夹


      // 关注用户


      // 点赞帖子


      // 浏览历史


      // 设置


    }.width('100%')
    .height('100%')
  }
}