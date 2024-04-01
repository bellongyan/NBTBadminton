import { CommonConstants } from '../../common/constants/CommonConstants'
import LoginUserInfo from '../../viewmodel/LoginUserInfo'
import CheckBoxAgreeDialog from './dialog/CheckBoxAgreeDialog'
import NullUsernamePassword from './dialog/NullUsernamePassword'
import { CryptoJS } from '@ohos/crypto-js'
import router from '@ohos.router'


@Component
export default struct LoginBody {
  nullUsernamePasswordController: CustomDialogController = new CustomDialogController({
    builder: NullUsernamePassword()
  })
  checkBoxAgreeDialogController: CustomDialogController = new CustomDialogController({
    builder: CheckBoxAgreeDialog()
  })
  @Prop username: string
  @Prop password: string
  @Prop isCheck: boolean

  build() {
    Column({ space: CommonConstants.SPACE_10 }) {
      TextInput({ placeholder: '账号' }).width(CommonConstants.THOUSANDTH_900)
        .type(InputType.Number)
        .onChange((value: string) => this.username = value)
      TextInput({ placeholder: '密码' }).width(CommonConstants.THOUSANDTH_900)
        .type(InputType.Password)
        .onChange((value: string) => this.password = value)

      Row() {
        Checkbox().onChange((value: boolean) => this.isCheck = value)
        Text('同意')
        Text('用户协议').fontWeight(FontWeight.Bold).onClick(() => {
          router.pushUrl({
            url: 'pages/UserAgreement'
          })
        })
        Text('和')
        Text('隐私政策').fontWeight(FontWeight.Bold)
      }

      Button('登录').type(ButtonType.Normal).width(300)
        .onClick(() => {
          if (this.isCheck === true) {
            if (this.username === '' || this.password == '') {
              this.nullUsernamePasswordController.open()
              console.log(this.username, this.password)
            }
            var pwd = CryptoJS.MD5(this.password).toString()
            let userInfo = JSON.stringify(new LoginUserInfo(this.username, pwd))

            // TODO: 网络请求验证
            if (true) {
              router.replaceUrl({
                url: 'pages/Index'
              })
            }

            console.log(userInfo)
          }
          else {
            this.checkBoxAgreeDialogController.open()
          }
        })
      Button('注册').type(ButtonType.Normal).width(300)
        .onClick(() => {
          // TODO: 注册页面的跳转
        })
    }
  }
}