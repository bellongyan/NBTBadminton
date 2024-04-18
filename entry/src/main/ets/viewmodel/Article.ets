export default class Article {
  articleId: number
  articleTitle: string
  content: string
  coverImg: string
  categoryId: number
  authorId: number
  createTime: string
  likeNum: number
  commentNum: number
  collectNum: number

  constructor(articleId: number, articleTitle: string, content: string, coverImg: string, categoryId: number, authorId: number, createTime: string, likeNum: number, commentNum: number, collectNum: number) {
    this.articleId = articleId
    this.articleTitle = articleTitle
    this.content = content
    this.coverImg = coverImg
    this.categoryId = categoryId
    this.authorId = authorId
    this.createTime = createTime
    this.likeNum = likeNum
    this.commentNum = commentNum
    this.collectNum = collectNum
  }
}