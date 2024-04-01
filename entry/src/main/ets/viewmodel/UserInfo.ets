export default class UserInfo {
  id: string
  nickname: string
  email: string
  sex: number

  constructor(id: string, nickname: string, email: string, sex: number) {
    this.id = id
    this.nickname = nickname
    this.email = email
    this.sex = sex
  }
}