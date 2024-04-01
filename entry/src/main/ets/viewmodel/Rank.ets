export default class Rank {
  id: number
  rank: number
  name: string
  nameChinese: string
  country: string
  secondName: string
  secondNameChinese: string
  secondCountry: string
  score: number
  steps: number
  attribute: number
  type: number

  constructor(id: number, rank: number, name: string, nameChinese: string, country: string, secondName: string, secondNameChinese: string, secondCountry: string, score: number, steps: number, attribute: number, type: number) {
    this.id = id
    this.rank = rank
    this.name = name;
    this.nameChinese = nameChinese
    this.country = country
    this.secondName = secondName
    this.secondNameChinese = secondNameChinese
    this.secondCountry = secondCountry
    this.score = score
    this.steps = steps
    this.attribute = attribute
    this.type = type
  }
}