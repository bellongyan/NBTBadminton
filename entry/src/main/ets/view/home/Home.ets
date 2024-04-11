import axios from '@ohos/axios'
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