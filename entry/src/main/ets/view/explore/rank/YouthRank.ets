import axios from '@ohos/axios'
import PreferenceUtil from '../../../common/utils/PreferenceUtil'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import Rank from '../../../viewmodel/Rank'
import RankBase from './RankBase'

const JWT_KEY = 'userJwtKey'

@Component
export default struct YouthRank {
  @State jwt: string = ''
  @State ranks: Rank[] = []

  async aboutToAppear() {
    let jwt_data = await PreferenceUtil.getPreferenceValue('JwtPref', JWT_KEY, null)
    this.jwt = jwt_data.toString()
    axios.get(CommonConstants.BASE_URL + "/ranks", {
      params: { attribute: 4, type: 6 },
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
        bgColor: $r('app.color.light_cyan'),
        fColor: $r('app.color.cyan'),
        title: "青年世界排名",
        attribute: 1,
        jwt: this.jwt.toString(),
        ranks: this.ranks
      })
    }
    .width('100%')
    .height('100%')
  }
}