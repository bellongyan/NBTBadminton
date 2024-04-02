import { CommonConstants } from '../../common/constants/CommonConstants'

@CustomDialog
export default struct ScoreRecordDialog {
  @Link firstPlayer: string
  @Link firstDoublesPlayer: string
  @Link secondPlayer: string
  @Link secondDoublePlayer: string
  @Link isDoubles: boolean
  controller: CustomDialogController

  build() {
    Column({ space: CommonConstants.SPACE_10 }) {
      Text('信息录入')

      TextInput({ placeholder: "请输入第一位选手姓名", text: this.firstPlayer}).onChange(value => {
        this.firstPlayer = value
      })

      if (this.isDoubles) {
        TextInput({ placeholder: "请输入第一位双打选手姓名" }).onChange(value => {
          this.firstDoublesPlayer = value
        })
      }


      TextInput({ placeholder: "请输入第二位选手姓名", text: this.secondPlayer}).onChange(value => {
        this.secondPlayer = value
      })

      if (this.isDoubles) {
        TextInput({ placeholder: "请输入第二位双打选手姓名" }).onChange(value => {
          this.secondDoublePlayer = value
        })

      }

      Button("确定").onClick(() => {
        this.controller.close()
      })
    }
    .width('100%')
    .padding(10)

  }
}