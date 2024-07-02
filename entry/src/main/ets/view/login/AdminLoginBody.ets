import { CommonConstants } from '../../common/constants/CommonConstants'
import CheckBoxAgreeDialog from '../dialog/CheckBoxAgreeDialog'
import NullUsernamePasswordDialog from '../dialog/NullUsernamePasswordDialog'
import router from '@ohos.router'
import axios from '@ohos/axios'
import common from '@ohos.app.ability.common'
import PreferenceUtil from '../../common/utils/PreferenceUtil'


const JWT_KEY = 'userJwtKey'
const MANAGER_KEY = 'isManagerKey'

@Component
export default struct AdminLoginBody {
  context = getContext(this) as common.UIAbilityContext
  nullUsernamePasswordController: CustomDialogController = new CustomDialogController({
    builder: NullUsernamePasswordDialog()
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
        .type(InputType.Normal)
        .onChange((value: string) => this.username = value)
      TextInput({ placeholder: '密码' }).width(CommonConstants.THOUSANDTH_900)
        .type(InputType.Password)
        .onChange((value: string) => this.password = value)

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

      Button('登录').type(ButtonType.Normal).width(300)
        .onClick(() => {
          if (this.isCheck === true) {
            if (this.username === '' || this.password == '') {
              this.nullUsernamePasswordController.open()
            } else {
              let qs = `adminId=${this.username}&password=${this.password}`
              axios.post("http://192.168.43.177:8080/admin/login", qs,
                { headers: { 'Content-Type': 'application/x-www-form-urlencoded' } }
              )
                .then(response => {
                  if (response.data.code === 0) {
                    let jwt = response.data.data
                    PreferenceUtil.putPreferenceValue('JwtPref', JWT_KEY, jwt)
                    PreferenceUtil.putPreferenceValue('ManagerPref', MANAGER_KEY, 1)
                    router.replaceUrl({
                      url: 'pages/Index',
                      params: {
                        isManager: 1
                      }
                    })
                  }
                })
            }
          }
          else {
            this.checkBoxAgreeDialogController.open()
          }
        })
    }
  }
}