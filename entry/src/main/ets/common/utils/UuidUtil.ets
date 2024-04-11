export default class UuidUtil {
  static generate(): string {
    // 生成 UUID 的方法
    const s4 = () => {
      return Math.floor((1 + Math.random()) * 0x10000)
        .toString(16)
        .substring(1);
    };
    return s4() + s4() + s4() + s4() + s4() + s4() + s4() + s4();
  }
}