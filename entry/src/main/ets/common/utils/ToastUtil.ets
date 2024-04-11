import promptAction from '@ohos.promptAction';

export function showToast(msg: string | Resource) {
  promptAction.showToast({
    message: msg,
    duration: 2000
  });
}