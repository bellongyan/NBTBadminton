export default class Event {
  event_id: number
  month: string
  duringDate: string
  name: string
  level: string
  position: string
  award: string
  isCancel: boolean

  constructor(event_id: number, month: string, duringDate: string, name: string, level: string, position: string, award: string, isCancel: boolean) {
    this.event_id = event_id
    this.month = month
    this.duringDate = duringDate
    this.name = name
    this.level = level
    this.position = position
    this.award = award
    this.isCancel = isCancel
  }
}