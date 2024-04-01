export default class UserInfo {
  userid: string
  password: string
  nickname: string
  email: string
  sex: number
  isBan: boolean

  constructor(userid: string, password: string, nickname: string, email: string, sex: number) {
    this.userid = userid
    this.password = password
    this.nickname = nickname
    this.email = email
    this.sex = sex
    this.isBan = false
  }
}