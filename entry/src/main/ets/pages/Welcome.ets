import router from '@ohos.router'
import common from '@ohos.app.ability.common'
import { CommonConstants } from '../common/constants/CommonConstants'
import PreferenceUtil from '../common/utils/PreferenceUtil'
import WelcomeUserPrivacyDialog from '../view/dialog/WelcomeUserPrivacyDialog'

@Extend(Text)
function opacityWhiteText(opacity: number, fontsize: number = 10) {
  .fontSize(fontsize).opacity(opacity).fontColor(Color.White)
}

const PREF_KEY = 'userPrivacyKey'

@Entry
@Component
struct Welcome {
  context = getContext(this) as common.UIAbilityContext
  controller: CustomDialogController = new CustomDialogController({
    builder: WelcomeUserPrivacyDialog({
      confirm: () => this.onConfirm(),
      cancel: () => this.exitApp()
    })
  })

  async aboutToAppear() {
    // 加载首选项
    let isAgree = await PreferenceUtil.getPreferenceValue('WelcomePref', PREF_KEY, false)
    // 加载弹窗
    // 同意跳转首页，不同意退出
    if (isAgree) {
      this.jumpToIndex()
    }
    else {
      this.controller.open()
    }
  }

  jumpToIndex() {
    setTimeout(() => {
      router.replaceUrl({
        url: 'pages/Index'
      })
    }, 1000)
  }

  exitApp() {
    // 退出APP
    this.context.terminateSelf()
  }

  onConfirm() {
    // 保存首选项
    PreferenceUtil.putPreferenceValue('WelcomePref', PREF_KEY, true)
    // 跳转到主页
    this.jumpToIndex()

  }

  build() {
    Column({ space: CommonConstants.SPACE_10 }) {
      Row() {
        Image($r("app.media.home_slogan")).width(280)
      }.layoutWeight(1)


      Row() {
        Text('宁理羽球在线支持').opacityWhiteText(0.8, 12)
        Text('IPv6')
          .opacityWhiteText(0.8)
          .fontColor(Color.White)
          .border({ style: BorderStyle.Solid, width: 1, color: Color.White, radius: 16 })
          .padding({ left: 5, right: 5 })
        Text('网络').fontSize(12).opacity(0.8).fontColor(Color.White)
      }

      Text(`宁理羽球在线旨在为宁理学子提供高质量在线羽毛球社区`)
        .opacityWhiteText(0.6, 10)

      Text('浙ICP备0000000号-36D')// margin是内边距，padding是外边距
        .opacityWhiteText(0.4).margin({ bottom: 35 })

    }
    .backgroundColor($r('app.color.primary_blue'))
    .width('100%')
    .height('100%')
  }
}