import axios from '@ohos/axios'
import PreferenceUtil from '../../../common/utils/PreferenceUtil'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import HomeHeader from '../../../conponent/HomeHeader'
import Rank from '../../../viewmodel/Rank'

const JWT_KEY = 'userJwtKey'

@Extend(Button)
function contentSelectButton() {
  .type(ButtonType.Normal)
  .backgroundColor($r('app.color.light_yellow'))
  .fontColor($r('app.color.yellow'))
  .fontSize(14)
  .height(30)
  .width('18%')
}

@Component
export default struct OlympicRank {
  @State jwt: string = ''
  @State ranks: Rank[] = []

  async aboutToAppear() {
    let jwt_data = await PreferenceUtil.getPreferenceValue('JwtPref', JWT_KEY, null)
    this.jwt = jwt_data.toString()
    axios.get("http://192.168.43.177:8080/ranks/3/6", {
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
      HomeHeader({ isBack: true, title: '奥运积分排名', headerBackgroundColor: $r('app.color.yellow') })

      Row({ space: CommonConstants.SPACE_6 }) {

        // 男子单打
        Button($r('app.string.man_single')).contentSelectButton().onClick(() => {
          axios.get("http://192.168.43.177:8080/ranks/3/6", {
            params: { attribute: 3, type: 6 },
            headers:
            {
              "Authorization": this.jwt
            }
          }).then(response => {
            if (response.data.code === 0) {
              let obj = JSON.parse(JSON.stringify(response.data.data))
              this.ranks = obj
            }
          })
        })
        // 女子单打
        Button($r('app.string.woman_single')).contentSelectButton().onClick(() => {
          axios.get("http://192.168.43.177:8080/ranks/3/7", {
            params: { attribute: 3, type: 7 },
            headers:
            {
              "Authorization": this.jwt
            }
          }).then(response => {
            if (response.data.code === 0) {
              let obj = JSON.parse(JSON.stringify(response.data.data))
              this.ranks = obj
            }
          })
        })

        // 男子双打
        Button($r('app.string.man_double')).contentSelectButton().onClick(() => {
          axios.get("http://192.168.43.177:8080/ranks/3/8", {
            params: { attribute: 3, type: 8 },
            headers:
            {
              "Authorization": this.jwt
            }
          }).then(response => {
            if (response.data.code === 0) {
              let obj = JSON.parse(JSON.stringify(response.data.data))
              this.ranks = obj
            }
          })
        })

        // 女子双打
        Button($r('app.string.women_double')).contentSelectButton().onClick(() => {
          axios.get("http://192.168.43.177:8080/ranks/3/9", {
            params: { attribute: 3, type: 9 },
            headers:
            {
              "Authorization": this.jwt
            }
          }).then(response => {
            if (response.data.code === 0) {
              let obj = JSON.parse(JSON.stringify(response.data.data))
              this.ranks = obj
            }
          })
        })

        // 混合双打
        Button($r('app.string.mixed_doubles')).contentSelectButton().onClick(() => {
          axios.get("http://192.168.43.177:8080/ranks/3/10", {
            params: { attribute: 3, type: 10 },
            headers:
            {
              "Authorization": this.jwt
            }
          }).then(response => {
            if (response.data.code === 0) {
              let obj = JSON.parse(JSON.stringify(response.data.data))
              this.ranks = obj
            }
          })
        })
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')

      Row() {
        Text('排名').fontSize(16).width(40)
        Text('国家').fontSize(16)

        Column() {
          Text('球员').fontSize(16)
        }.layoutWeight(1)

        Text('积分').fontSize(16)
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .backgroundColor($r('app.color.light_yellow'))
      .width('100%')
      .height(40)

      //   数据
      List() {
        ForEach(this.ranks, (item: Rank) => {
          ListItem() {
            Row() {
              this.RankCard(item)
            }
          }
        })
      }
      .width('100%')
      .height('100%')
      .layoutWeight(1)

    }
    .width('100%')
    .height('100%')
  }

  @Builder
  RankCard($$: {
    rank: number,
    country: string,
    secondCountry?: string,
    name: string,
    nameChinese: string,
    secondName?: string,
    secondNameChinese?: string,
    score: number
  }) {
    Row() {
      Text($$.rank.toString()).fontSize(20).fontWeight(FontWeight.Bold).width(40)
      Column() {
        Text($$.country).fontSize(14)
        Text($$.secondCountry).fontSize(14)
      }

      Column() {
        Text($$.nameChinese).fontSize(14)
        Text($$.name).fontSize(10)
        Text($$.secondNameChinese).fontSize(14)
        Text($$.secondName).fontSize(10)
      }.layoutWeight(1)

      Text($$.score.toString()).fontSize(16)
    }
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.White)
    .width('94%')
    .height(70)
  }
}