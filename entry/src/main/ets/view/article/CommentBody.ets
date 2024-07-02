import { CommonConstants } from '../../common/constants/CommonConstants'

@Component
export default struct CommentBody {
  build() {
    Column({ space: CommonConstants.SPACE_10 }) {

      Column({ space: CommonConstants.SPACE_10 }) {
        Row({ space: CommonConstants.SPACE_10 }) {
          Text('終末の花海').fontSize(16)
          Text('发布时间：2024-04-29 03:26').fontSize(12).opacity(0.7)
        }

        Row() {
          Text("春风若有怜花意\n可否许我再少年").fontSize(18).layoutWeight(1)
          Blank()
          Column() {
            Image($r('app.media.like')).height(20).fillColor(Color.Red)
            Text('143').fontSize(12).fontColor(Color.Black).opacity(0.8)
          }
        }
      }
      .padding({ top: 10, left: 20, right: 20, bottom: 10 })
      .alignItems(HorizontalAlign.Start)
      .borderRadius(10)
      .backgroundColor($r('app.color.white_cloud'))
      .width('100%')

      Column({ space: CommonConstants.SPACE_10 }) {
        Row({ space: CommonConstants.SPACE_10 }) {
          Text('默默默然').fontSize(16)
          Text('发布时间：2024-04-28 13:13').fontSize(12).opacity(0.7)
        }

        Row() {
          Text("曾经有人嫌弃桃田的拉吊，直到出现了奈良，现在桃要退役了，拉吊的顶端也就剩下了昆奈表演世锦赛决赛")
            .fontSize(18)
            .layoutWeight(1)
          Blank()
          Column() {
            Image($r('app.media.like')).height(20).fillColor(Color.Red)
            Text('143').fontSize(12).fontColor(Color.Black).opacity(0.8)
          }
        }
      }
      .padding({ top: 10, left: 20, right: 20, bottom: 10 })
      .alignItems(HorizontalAlign.Start)
      .borderRadius(10)
      .backgroundColor($r('app.color.white_cloud'))
      .width('100%')

      Column({ space: CommonConstants.SPACE_10 }) {
        Row({ space: CommonConstants.SPACE_10 }) {
          Text('czb2133').fontSize(16)
          Text('发布时间：2024-04-28 04:22').fontSize(12).opacity(0.7)
        }

        Row() {
          Text("18-20年的王者，巅峰期如流星般短暂，虽然名字不会有林李谌般响亮，但是足够在羽坛留下一笔了，致敬桃子，祝万事顺遂。")
            .fontSize(18)
            .layoutWeight(1)
          Blank()
          Column() {
            Image($r('app.media.like')).height(20).fillColor(Color.Red)
            Text('143').fontSize(12).fontColor(Color.Black).opacity(0.8)
          }
        }
      }
      .padding({ top: 10, left: 20, right: 20, bottom: 10 })
      .alignItems(HorizontalAlign.Start)
      .borderRadius(10)
      .backgroundColor($r('app.color.white_cloud'))
      .width('100%')

      Column({ space: CommonConstants.SPACE_10 }) {
        Row({ space: CommonConstants.SPACE_10 }) {
          Text('x=y(f)').fontSize(16)
          Text('发布时间：2024-04-28 4:16').fontSize(12).opacity(0.7)
        }

        Row() {
          Text("不曾在你巅峰时慕名而来\n也未曾在你低谷时离去\n辉煌的太阳橙立于世界之巅\n低谷的白虎纹隐于山林之间\n一年十一冠的辉煌世界纪录历历在目\n但随之而来的各种打击也让你一蹶不振\n一直调侃你的比赛看一场少一场\n曾经的王者也将引来谢幕之战\nMOMOTA退役快乐")
            .fontSize(18)
            .layoutWeight(1)
          Blank()
          Column() {
            Image($r('app.media.like')).height(20).fillColor(Color.Red)
            Text('143').fontSize(12).fontColor(Color.Black).opacity(0.8)
          }
        }
      }
      .padding({ top: 10, left: 20, right: 20, bottom: 10 })
      .alignItems(HorizontalAlign.Start)
      .borderRadius(10)
      .backgroundColor($r('app.color.white_cloud'))
      .width('100%')

      Column({ space: CommonConstants.SPACE_10 }) {
        Row({ space: CommonConstants.SPACE_10 }) {
          Text('bel homme').fontSize(16)
          Text('发布时间：2024-04-28 03:21').fontSize(12).opacity(0.7)
        }

        Row() {
          Text("口袋哥差远了，桃的拉吊质量高，突击能力强。").fontSize(18).layoutWeight(1)
          Blank()
          Column() {
            Image($r('app.media.like')).height(20).fillColor(Color.Red)
            Text('143').fontSize(12).fontColor(Color.Black).opacity(0.8)
          }
        }
      }
      .padding({ top: 10, left: 20, right: 20, bottom: 10 })
      .alignItems(HorizontalAlign.Start)
      .borderRadius(10)
      .backgroundColor($r('app.color.white_cloud'))
      .width('100%')

    }
    .height('100%')
    .width('100%')

  }
}