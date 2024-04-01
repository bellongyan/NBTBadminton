import CryptoJS from '@ohos/crypto-js'

export default class LoginUserInfo {
  username: string
  password: string

  constructor(username: string, password: string) {
    var pwd = CryptoJS.MD5(password).toString()
    this.username = username
    this.password = pwd
  }
}
