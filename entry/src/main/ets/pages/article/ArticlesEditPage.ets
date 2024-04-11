import HomeHeader from '../../conponent/HomeHeader'
import axios from '@ohos/axios'
import PreferenceUtil from '../../common/utils/PreferenceUtil'
import Category from '../../viewmodel/Category'
import { CommonConstants } from '../../common/constants/CommonConstants'
import { fileSelect, fileUpload } from '../../common/utils/FileUtils'
import { showToast } from '../../common/utils/ToastUtil'
import router from '@ohos.router'


const JWT_KEY = 'userJwtKey'


@Entry
@Component
struct ArticleEditPage {
  @State jwt: string = ''
  @State imageUri: string = ''
  @State imageUrl: string = ''
  @State categories: Category[] = []
  @State title: string = ''
  @State content: string = ''
  @State categoryId: number = 1
  @State categoryNames: string[] = []

  async aboutToAppear() {
    let jwt_data = await PreferenceUtil.getPreferenceValue('JwtPref', JWT_KEY, null)
    this.jwt = jwt_data.toString()
    //   获取所有分类
    var config = {
      method: 'get',
      url: CommonConstants.BASE_URL + '/categories',
      headers: { 'Authorization': this.jwt, }
    };
    axios(config).then((response) => {
      if (response.data.code === 0) {
        let obj = JSON.parse(JSON.stringify(response.data.data))
        this.categories = obj
        console.log("category: " + JSON.stringify(this.categories))
        this.categoryNames = this.categories.map(item => item.categoryName)
      }
    }).catch(function (error) {
      console.log(error);
    });
  }

  selectImage() {
    fileSelect().then((uri: string) => {
      this.imageUri = uri;
    });
  }

  uploadArticleData() {
    let serverData = fileUpload(getContext(this), this.imageUri);
    serverData.then((data) => {
      this.imageUrl = data.data.toString()
    })

    var data = JSON.stringify({
      "articleTitle": this.title,
      "content": this.content,
      "coverImg": this.imageUrl,
      "categoryId": this.categoryId
    });

    var config = {
      method: 'post',
      url: 'http://192.168.43.177:8080/articles/add',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': this.jwt,
      },
      data: data
    };
    axios(config)
      .then((response) => {
        if (response.data.code === 0) {
          showToast("发布成功！")
          router.back()
        }
        console.log(JSON.stringify(response.data));
      })
      .catch(function (error) {
        console.log(error);
      });
  }

  build() {
    Column() {
      HomeHeader({ isBack: true, title: '新增帖子', headerBackgroundColor: $r('app.color.white_silver') })

      Column() {
        // 标题输入
        TextInput({ placeholder: '帖子标题' })
          .fontSize(16)
          .placeholderFont({ size: 16 })
          .margin({ top: 12 })
          .fontColor('#182431')
          .backgroundColor(Color.White)
          .onChange((value: string) => {
            this.title = value
          })
          .width('100%')
          .height(44)

        Divider()
          .opacity(0.05)
          .color('#182431')
          .width('90%')

        // 内容输入
        TextArea({ placeholder: '写点什么' })
          .fontSize(16)
          .placeholderFont({ size: 16 })
          .margin({ top: 8 })
          .fontColor('#182431')
          .backgroundColor(Color.White)
          .onChange((value: string) => {
            this.content = value
          })
          .width('100%')
          .height(180)

        Scroll() {
          Row() {
            Image(this.imageUri ? this.imageUri : $r('app.media.ic_add_pic'))
              .width(100)
              .height(100)
              .objectFit(ImageFit.Cover)
              .onClick(() => this.selectImage())
          }
          .padding(20)
        }
        .width('100%')
        .scrollable(ScrollDirection.Horizontal)
        .align(Alignment.Start)

        TextPicker({ range: this.categoryNames, selected: 0 })
          .padding({ top: CommonConstants.SPACE_12, bottom: CommonConstants.SPACE_12 })
          .defaultPickerItemHeight(28)
          .onChange((value: string, index: number) => {
            this.categoryId = index + 1
          })
      }
      .borderRadius(20)
      .backgroundColor(Color.White)
      .margin({ top: CommonConstants.SPACE_12 })
      .padding({ bottom: CommonConstants.SPACE_12 })
      .width('94%')

      Row({ space: CommonConstants.SPACE_12 }) {

        Button('发布')
          .fontSize(16)
          .height(40)
          .width(200)
          .margin({ bottom: 12 })
          .type(ButtonType.Normal)
          .onClick(() => this.uploadArticleData())
      }.padding({ top: 50 })

    }
    // .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}