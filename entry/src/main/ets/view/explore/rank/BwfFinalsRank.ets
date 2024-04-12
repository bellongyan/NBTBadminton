import axios from '@ohos/axios'
import PreferenceUtil from '../../../common/utils/PreferenceUtil'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import HomeHeader from '../../../conponent/HomeHeader'
import Rank from '../../../viewmodel/Rank'
import RankBase from './RankBase'

const JWT_KEY = 'userJwtKey'

@Component
export default struct BwfFinalsRank {
  @State jwt: string = ''
  @State ranks: Rank[] = []

  async aboutToAppear() {
    let jwt_data = await PreferenceUtil.getPreferenceValue('JwtPref', JWT_KEY, null)
    this.jwt = jwt_data.toString()
    axios.get(CommonConstants.BASE_URL + "/ranks/2/6", {
      headers:
      {
        "Authorization": jwt_data.toString()
      }
    }).then(response => {
      if (response.data.code === 0) {
        let obj = JSON.parse(JSON.stringify(response.data.data))
        this.ranks = obj
      }
    })
  }

  build() {
    Column({ space: CommonConstants.SPACE_4 }) {
      RankBase({
        bgColor: $r('app.color.light_purple'),
        fColor: $r('app.color.purple'),
        title: "BWF总决赛积分排名",
        attribute: 2,
        jwt: this.jwt.toString(),
        ranks: this.ranks
      })
    }
    .width('100%')
    .height('100%')
  }
}