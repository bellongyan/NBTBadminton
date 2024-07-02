import { CommonConstants } from '../common/constants/CommonConstants'
import PreferenceUtil from '../common/utils/PreferenceUtil'
import Explore from '../view/explore/Explore'
import Home from '../view/home/Home'
import Jwt from '../viewmodel/Jwt'
import systemDateTime from '@ohos.systemDateTime'
import Base64Util from '../common/utils/Base64Util'
import ExpireDialog from '../view/dialog/ExpireDialog'
import Community from '../view/community/Community'
import MainTabs from '../view/main/MainTabs'
import AdminBody from '../view/admin/AdminBody'
import router from '@ohos.router'

const JWT_KEY = 'userJwtKey'
const MANAGER_KEY = 'isManagerKey'

@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  @State isPageShow: boolean = false
  @State isManager: number = 0
  expireDialogController: CustomDialogController = new CustomDialogController({
    builder: ExpireDialog()
  })

  async aboutToAppear() {
    // this.isManager = router.getParams()['isManager']
    let tag = await PreferenceUtil.getPreferenceValue('ManagerPref', MANAGER_KEY, 0)
    this.isManager = Number(tag.toString())
    console.log("this.isManager: =====> " + this.isManager)
    let jwt_data = await PreferenceUtil.getPreferenceValue('JwtPref', JWT_KEY, null)
    let jwt = jwt_data.toString().split(".")[1]

    const encodedString: string = jwt;
    let decodedString: string = Base64Util.decode(encodedString);
    decodedString = decodedString.substring(0, decodedString.length - 1)

    let jwtInfo: Jwt = null
    jwtInfo = JSON.parse(decodedString)

    let expTime = jwtInfo.exp

    try {
      systemDateTime.getCurrentTime(false, (error, time) => {
        if (error) {
          console.info(`Failed to get currentTime. message:${error.message}, code:${error.code}`);
          return;
        }
        console.info(`Succeeded in getting currentTime : ${time}`);
        let currentTime = time.toString().substring(0, time.toString().length - 3)
        if (currentTime >= expTime) {
          this.expireDialogController.open()
        }
      });
    } catch (e) {
      console.info(`Failed to get currentTime. message:${e.message}, code:${e.code}`);
    }
  }

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        MainTabs()
      }.tabBar(this.TabBarBuilder($r('app.string.main_page'), $r('app.media.home'), 0))

      TabContent() {
        Community()
      }.tabBar(this.TabBarBuilder($r('app.string.community'), $r('app.media.community'), 1))

      TabContent() {
        Explore()
      }.tabBar(this.TabBarBuilder($r('app.string.explore'), $r('app.media.explore'), 2))

      TabContent() {
        Home()
      }.tabBar(this.TabBarBuilder($r('app.string.me'), $r('app.media.me'), 3))

      if (this.isManager === 0) {
        TabContent() {
          AdminBody()
        }.tabBar(this.TabBarBuilder('管理', $r('app.media.message'), 4))
      }

    }
    .width('100%')
    .height('100%')
    .onChange(index => {
      this.currentIndex = index
    })
  }

  @Builder
  TabBarBuilder(title: ResourceStr, image: ResourceStr, index: number) {
    Column({ space: CommonConstants.SPACE_8 }) {
      Image(image).width(22).fillColor(this.selectColor(index))
      Text(title).fontSize(14).fontColor(this.selectColor(index))
    }
  }

  selectColor(index: number) {
    return this.currentIndex === index ? $r('app.color.primary_blue') : $r('app.color.gray')
  }
}