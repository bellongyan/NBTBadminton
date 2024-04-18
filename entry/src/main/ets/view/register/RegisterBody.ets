import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'
import UserInfo from '../../viewmodel/UserInfo'
import CheckBoxAgreeDialog from '../dialog/CheckBoxAgreeDialog'
import FullRegisterInfoDialog from '../dialog/FullRegisterInfoDialog'
import axios from '@ohos/axios'

@Extend(Text)
function textStyle() {
  .fontSize(16).width(100).textAlign(TextAlign.Center)
}

@Component
export default struct RegisterBody {
  fullRegisterInfoDialogController: CustomDialogController = new CustomDialogController({
    builder: FullRegisterInfoDialog()
  })
  checkBoxAgreeDialogController: CustomDialogController = new CustomDialogController({
    builder: CheckBoxAgreeDialog()
  })
  @Prop isCheck: boolean
  @State isPasswordSame: boolean = false
  @State username: string = ''
  @State nickname: string = ''
  @State password: string = ''
  @State repeatPassword: string = ''
  @State email: string = ''
  @State sex: number = 1
  @State isMan: boolean = true
  @State isWoman: boolean = false

  build() {
    Column({ space: CommonConstants.SPACE_10 }) {
      Column({ space: CommonConstants.SPACE_10 }) {

        // 学号 用户名
        Row({ space: CommonConstants.SPACE_10 }) {
          Text($r('app.string.Student_ID')).textStyle()
          TextInput({ placeholder: $r('app.string.Hint_Student_ID') }).layoutWeight(1).type(InputType.Number)
            .onChange(value => {
              this.username = value
            })
        }

        // 密码
        Row({ space: CommonConstants.SPACE_10 }) {
          Text($r('app.string.Password')).textStyle()
          TextInput({ placeholder: $r('app.string.Hint_Password') }).layoutWeight(1).type(InputType.Password)
            .onChange(value => {
              this.password = value
              if (this.password == this.repeatPassword) {
                this.isPasswordSame = true
              } else {
                this.isPasswordSame = false
              }
            })
        }

        // 再次输入密码
        Row({ space: CommonConstants.SPACE_10 }) {
          Text($r('app.string.Repeat_Password')).textStyle()
          TextInput({ placeholder: $r('app.string.Hint_Repeat_Password') }).layoutWeight(1).type(InputType.Password)
            .onChange(value => {
              this.repeatPassword = value

              if (this.password == this.repeatPassword) {
                this.isPasswordSame = true
              } else {
                this.isPasswordSame = false
              }
            })
        }

        // 昵称
        Row({ space: CommonConstants.SPACE_10 }) {
          Text($r('app.string.Nickname')).textStyle()
          TextInput({ placeholder: $r('app.string.Hint_Nickname') }).layoutWeight(1)
            .onChange(value => {
              this.nickname = value
            })
        }

        // 性别
        Row({ space: CommonConstants.SPACE_10 }) {
          Text($r('app.string.Sex')).textStyle()
          Row({ space: CommonConstants.SPACE_10 }) {
            Checkbox()
              .select(this.isMan)
              .onClick(() => {
                this.sex = 1
                this.isMan = true
                this.isWoman = false
              })
            Text($r('app.string.Man'))
            Checkbox()
              .select(this.isWoman)
              .onClick(() => {
                this.sex = 0
                this.isWoman = true
                this.isMan = false
              })
            Text($r('app.string.Woman'))
          }.layoutWeight(1)
        }

        // 邮箱
        Row({ space: CommonConstants.SPACE_10 }) {
          Text($r('app.string.Email')).textStyle()
          TextInput({ placeholder: $r('app.string.Hint_Email') }).layoutWeight(1).type(InputType.Email)
            .onChange(value => {
              this.email = value
            })
        }

        Row() {
          Checkbox().onChange((value: boolean) => this.isCheck = value)
          Text('同意')
          Text('用户协议').fontWeight(FontWeight.Bold).onClick(() => {
            router.pushUrl({
              url: 'pages/home/UserAgreement'
            })
          })
          Text('和')
          Text('隐私政策').fontWeight(FontWeight.Bold)
        }

        // 密码不一样警告
        if (this.isPasswordSame === false && this.repeatPassword !== '') {
          Text($r('app.string.Warm_Repeat_Password')).fontColor(Color.Red).fontSize(18).visibility(Visibility.Visible)
        }
        else {
          Text($r('app.string.Warm_Repeat_Password')).fontColor(Color.Red).fontSize(18).visibility(Visibility.Hidden)
        }
      }
      .width(CommonConstants.THOUSANDTH_940)

      Button('注册').type(ButtonType.Normal).width(300)
        .onClick(() => {
          if (this.username === '' || this.password === '' || this.repeatPassword === '' ||
            this.nickname === '' || this.email === '') {
            this.fullRegisterInfoDialogController.open()
          }
          if (this.isCheck === false) {
            this.checkBoxAgreeDialogController.open()
          }
          if (this.isPasswordSame) {
            new UserInfo(this.username, this.password, this.nickname, this.email, this.sex)
            // TODO: 发送信息到后端，信息注册成功

            let qs = `userid=${this.username}&password=${this.password}&nickname=${this.nickname}&sex=${this.sex}&email=${this.email}`
            axios.post(
              "http://192.168.43.177:8080/users/register", qs,
              { headers: { 'Content-Type': 'application/x-www-form-urlencoded' } }
            ).then(response => {
              router.back();
            }).catch(error => {
              console.log(error)
            })

          }
        })
    }
    .justifyContent(FlexAlign.SpaceEvenly)
    .height('100%')
    .width('100%')
  }
}