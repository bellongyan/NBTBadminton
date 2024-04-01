import axios from '@ohos/axios'
import { CommonConstants } from '../../common/constants/CommonConstants'
import PreferenceUtil from '../../common/utils/PreferenceUtil'
import HomeHeader from '../../conponent/HomeHeader'
import Event from '../../viewmodel/Event'

const JWT_KEY = 'userJwtKey'

@Entry
@Component
struct EventCalendar {
  @State jwt: string = ''
  @State events: Event[] = []

  async aboutToAppear() {
    let jwt_data = await PreferenceUtil.getPreferenceValue('JwtPref', JWT_KEY, null)
    this.jwt = jwt_data.toString()

    axios.get(CommonConstants.BASE_URL + "/events", {
      headers: { 'Authorization': this.jwt }
    }).then(response => {
      if (response.data.code === 0) {
        let obj = JSON.parse(JSON.stringify(response.data.data))
        this.events = obj
      }
    })
  }

  build() {
    Column() {
      HomeHeader({ isBack: true, title: '2024年羽毛球赛事日历', headerBackgroundColor: $r('app.color.red') })

      //   数据
      List() {
        ForEach(this.events, (item: Event) => {
          ListItem() {
            Column() {
              this.EventCard(item)
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
  EventCard($$: {
    event_id: number
    month: string
    duringDate: string
    name: string
    level: string
    position: string
    award: string
    isCancel: boolean
  }) {
    Row({ space: CommonConstants.SPACE_6 }) {
      Column() {
        Text($$.month + "月")
        Text($$.duringDate)
      }

      Blank()

      Column() {
        Text($$.name).fontSize(20)
        Row() {
          if ($$.level !== null) {
            Text("等级：" + $$.level).fontSize(12).opacity(0.5)
          }
          if ($$.position !== null) {
            Text('|地点：' + $$.position).fontSize(12).opacity(0.5)
          }
          if ($$.award !== null) {
            Text('|奖金' + $$.award).fontSize(12).opacity(0.5)
          }
        }
      }

      Blank()

      if ($$.isCancel === true) {
        Text("已取消").visibility(Visibility.Visible).fontSize(12).opacity(0.8)
      }
      else {
        Text("已取消").visibility(Visibility.Hidden)
      }

    }
    .width('100%')
    .height(60)
  }
}