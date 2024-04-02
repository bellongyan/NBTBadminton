import { CommonConstants } from '../../common/constants/CommonConstants'
import HomeHeader from '../../conponent/HomeHeader'
import ScoreRecordDialog from '../../view/dialog/ScoreRecordDialog'
import { McLineChart, Options } from '@mcui/mccharts'

@Extend(Button)
function buttonStyles(width: number) {
  .type(ButtonType.Normal).width(width).backgroundColor($r('app.color.gray'))
}

@Extend(Text)
function nameStyles() {
  .fontSize(24).opacity(0.8)
}

@Entry
@Component
struct ScoreRecord {
  @State firstPlayer: string = "First Player"
  @State firstDoublesPlayer: string = "First Doubles Player"
  @State secondPlayer: string = "Second Player"
  @State secondDoublePlayer: string = "Second Doubles Player"
  @State isDoubles: boolean = false
  @State indexStr: number = 0
  @State index: string[] = ['0']
  @State Score1: number = 0
  @State Score2: number = 0
  @State firstScores: number[] = [0]
  @State secondScores: number[] = [0]
  @State defOptions: Options = new Options({
    xAxis: {
      data: this.index
    },
    yAxis: {
      name: '比分'
    },
    series: [
      {
        name: this.firstPlayer,
        data: this.firstScores
      },
      {
        name: this.secondPlayer,
        data: this.secondScores
      }
    ]
  })
  scoreRecordDialogController: CustomDialogController = new CustomDialogController({
    builder: ScoreRecordDialog({
      firstPlayer: $firstPlayer,
      firstDoublesPlayer: $firstDoublesPlayer,
      secondPlayer: $secondPlayer,
      secondDoublePlayer: $secondDoublePlayer,
      isDoubles: $isDoubles
    })
  })

  onUpdate(score1: number, score2: number) {
    this.indexStr++
    this.index.push(this.indexStr.toString())
    this.Score1 = score1
    this.Score2 = score2
    this.firstScores.push(this.Score1)
    this.secondScores.push(this.Score2)

    console.log(this.Score1.toString())
    console.log(this.Score2.toString())

    this.defOptions.setVal({
      series: [
        {
          name: this.firstPlayer,
          data: this.firstScores
        },
        {
          name: this.secondPlayer,
          data: this.secondScores
        }
      ]
    })
  }

  build() {
    Column({ space: CommonConstants.SPACE_10 }) {
      HomeHeader({ isBack: true, title: '羽毛球计分工具', headerBackgroundColor: $r('app.color.green_badminton') })

      Row({ space: CommonConstants.SPACE_10 }) {
        Button('单打(Singles)').type(ButtonType.Normal).buttonStyles(160)
          .onClick(() => {
            this.isDoubles = false
            this.scoreRecordDialogController.open()
          })
        Button('双打(Doubles)').type(ButtonType.Normal).buttonStyles(160)
          .onClick(() => {
            this.isDoubles = true
            this.scoreRecordDialogController.open()
          })
      }


      Column() {
        Text(this.firstPlayer).nameStyles()
        if (this.isDoubles) {
          Text(this.firstDoublesPlayer).visibility(Visibility.Visible).nameStyles()
        }
        Column({ space: CommonConstants.SPACE_10 }) {
          Text(this.Score1.toString()).fontSize(36).fontWeight(FontWeight.Bold)

          Text('VS').fontSize(24)

          Text(this.Score2.toString()).fontSize(36).fontWeight(FontWeight.Bold)
        }

        if (this.isDoubles) {
          Text(this.secondDoublePlayer).visibility(Visibility.Visible).nameStyles()
        }
        Text(this.secondPlayer).nameStyles()
      }.layoutWeight(1)

      McLineChart({ options: this.defOptions as Options })
        .height(300)
        .borderRadius(10)


      Row({ space: CommonConstants.SPACE_10 }) {
        Button(`${this.firstPlayer} 加分`).buttonStyles(170).shadow({ radius: 10 })
          .onClick(() => {
            // 中止更新条件
            if ((this.Score1 >= 21 && this.Score1 < 29) || (this.Score2 >= 21 && this.Score2 < 29)) {
              if (Math.abs(this.Score1 - this.Score2) >= 2) {
                return
              }
              else {
                this.onUpdate(++this.Score1, this.Score2)
              }
            } else if (this.Score1 === 30 || this.Score2 === 30) {
              return
            } else {
              this.onUpdate(++this.Score1, this.Score2)
            }

          })

        Button(`${this.secondPlayer} 加分`).buttonStyles(170).shadow({ radius: 10 })
          .onClick(() => {
            // 中止更新条件
            if ((this.Score1 >= 21 && this.Score1 < 29) || (this.Score2 >= 21 && this.Score2 < 29)) {
              if (Math.abs(this.Score1 - this.Score2) >= 2) {
                return
              }
              else {
                this.onUpdate(this.Score1, ++this.Score2)
              }
            } else if (this.Score1 === 30 || this.Score2 === 30) {
              return
            }
            else {
              this.onUpdate(this.Score1, ++this.Score2)
            }
          })
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .backgroundColor($r('app.color.white_silver'))
      .padding({ top: CommonConstants.DEFAULT_20, bottom: CommonConstants.DEFAULT_20 })
    }
    .width('100%')
    .height('100%')
  }
}