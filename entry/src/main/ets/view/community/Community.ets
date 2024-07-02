import axios from '@ohos/axios';
import router from '@ohos.router';
import { CommonConstants } from '../../common/constants/CommonConstants';
import HomeHeader from '../../conponent/HomeHeader'
import Category from '../../viewmodel/Category';
import PreferenceUtil from '../../common/utils/PreferenceUtil';

const JWT_KEY = 'userJwtKey'

@Component
export default struct Community {
  @State categories: Category[] = []
  @State jwt: string = ''

  async aboutToAppear() {
    let jwt_data = await PreferenceUtil.getPreferenceValue('JwtPref', JWT_KEY, null)
    this.jwt = jwt_data.toString()

    axios('http://192.168.43.177:8080/categories', {
      headers: {
        Authorization: this.jwt,
      }
    }).then((response) => {
      this.categories = JSON.parse(JSON.stringify(response.data.data))
      console.log(this.categories[0].id.toString())
    }).catch((error) => {
      console.log(error);
    });
  }

  build() {
    Column() {
      HomeHeader({ isBack: false, title: '社区', headerBackgroundColor: $r('app.color.green_badminton') })

      Search({ placeholder: '搜索你感兴趣的内容' })

      Grid() {
        ForEach(this.categories, (item: Category) => {
          GridItem() {
            Text(item.categoryName)
              .textAlign(TextAlign.Center)
              .width(CommonConstants.THOUSANDTH_940)
              .fontSize(24)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .onClick(() => {
            router.pushUrl({
              url: 'pages/article/CategoryArticlesPage',
              params: {
                categoryName: item.categoryName,
                categoryId: item.id
              }
            })
          })
          .height(40)
          .backgroundColor($r('app.color.green_badminton'))
          .opacity(0.8)
        })
      }
      .padding({ top: 20 })
      .width(CommonConstants.THOUSANDTH_940)
      .columnsGap(10)
      .rowsGap(10)
      .columnsTemplate('1fr 1fr')

    }
    .height('100%')
    .width('100%')
  }
}