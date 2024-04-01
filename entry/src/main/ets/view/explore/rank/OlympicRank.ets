import axios from '@ohos/axios'
import PreferenceUtil from '../../../common/utils/PreferenceUtil'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import HomeHeader from '../../../conponent/HomeHeader'
import Rank from '../../../viewmodel/Rank'
import RankBase from './RankBase'

const JWT_KEY = 'userJwtKey'

@Component
export default struct OlympicRank {
  @State jwt: string = ''
  @State ranks: Rank[] = []

  async aboutToAppear() {
    let jwt_data = await PreferenceUtil.getPreferenceValue('JwtPref', JWT_KEY, null)
    this.jwt = jwt_data.toString()
    axios.get(CommonConstants.BASE_URL + "/ranks", {
      params: { attribute: 3, type: 6 },
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
        bgColor: $r('app.color.light_yellow'),
        fColor: $r('app.color.yellow'),
        title: '奥运积分排名',
        attribute: 3,
        jwt: this.jwt.toString(),
        ranks: this.ranks
      })
    }
    .width('100%')
    .height('100%')
  }
}