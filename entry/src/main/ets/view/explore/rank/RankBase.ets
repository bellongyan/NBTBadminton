import axios from '@ohos/axios'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import HomeHeader from '../../../conponent/HomeHeader'
import Rank from '../../../viewmodel/Rank'

@Extend(Button)
function contentSelectButton(bgColor: ResourceStr, fColor: ResourceStr) {
  .type(ButtonType.Normal)
  .backgroundColor(bgColor)
  .fontColor(fColor)
  .fontSize(14)
  .height(30)
  .width('18%')
}

@Component
export default struct RankBase {
  private bgColor: ResourceStr
  private fColor: ResourceStr
  @Prop title: string
  @Prop attribute: number
  @Prop jwt: string
  @Prop ranks: Rank[]

  build() {
    Column({ space: CommonConstants.SPACE_4 }) {
      HomeHeader({ isBack: true, title: this.title, headerBackgroundColor: this.fColor })

      Row({ space: CommonConstants.SPACE_6 }) {

        // 男子单打
        Button($r('app.string.man_single')).contentSelectButton(this.bgColor, this.fColor).onClick(() => {
          axios.get(CommonConstants.BASE_URL + "/ranks", {
            params: { attribute: this.attribute, type: 6 },
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
        Button($r('app.string.woman_single')).contentSelectButton(this.bgColor, this.fColor).onClick(() => {
          axios.get(CommonConstants.BASE_URL + "/ranks", {
            params: { attribute: this.attribute, type: 7 },
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
        Button($r('app.string.man_double')).contentSelectButton(this.bgColor, this.fColor).onClick(() => {
          axios.get(CommonConstants.BASE_URL + "/ranks", {
            params: { attribute: this.attribute, type: 8 },
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
        Button($r('app.string.women_double')).contentSelectButton(this.bgColor, this.fColor).onClick(() => {
          axios.get(CommonConstants.BASE_URL + "/ranks", {
            params: { attribute: this.attribute, type: 9 },
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
        Button($r('app.string.mixed_doubles')).contentSelectButton(this.bgColor, this.fColor).onClick(() => {
          axios.get(CommonConstants.BASE_URL + "/ranks", {
            params: { attribute: this.attribute, type: 10 },
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
      .backgroundColor(this.bgColor)
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