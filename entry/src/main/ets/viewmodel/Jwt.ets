export default class Jwt {
  claims: object
  exp: string

  constructor(claims: object, exp: string) {
    this.claims = claims
    this.exp = exp
  }
}