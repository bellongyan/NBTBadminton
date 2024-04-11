import picker from '@ohos.file.picker';
import request from '@ohos.request';
import ResponseResult from '../../viewmodel/ResponseResult';
import { CommonConstants, ContentType, RequestMethod, UploadingState } from '../constants/CommonConstants';
import Logger from './Logger';
import { showToast } from './ToastUtil';
import fs from '@ohos.file.fs';
import UuidUtil from './UuidUtil';


/**
 * PhotoViewPicker
 *
 * @returns uri The uri for the selected file.
 */
export async function fileSelect(): Promise<string> {
  let photoSelectOptions = new picker.PhotoSelectOptions();
  photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
  photoSelectOptions.maxSelectNumber = 1;
  let photoPicker = new picker.PhotoViewPicker();

  try {
    let photoSelectResult = await photoPicker.select(photoSelectOptions);

    if (photoSelectResult && photoSelectResult.photoUris && photoSelectResult.photoUris.length > 0) {
      let imgUri = photoSelectResult.photoUris[0];
      if (imgUri.indexOf('media/image') < 0) {
        showToast($r('app.string.prompt_select_img'));
        return '';
      }
      return imgUri;
    } else {
      return '';
    }
  } catch (err) {
    Logger.error('SelectedImage failed', JSON.stringify(err));
    return '';
  }
}

/**
 * Upload file.
 *
 * @param context Indicates the application BaseContext.
 * @param fileUri The local storage path of the file.
 * @returns the promise returned by the function.
 */
export function fileUpload(context: Context, fileUri: string): Promise<ResponseResult> {
  // Obtaining the Application File Path.
  let cacheDir = context.cacheDir;
  let imgName = fileUri.split('/').pop() + '.jpg';
  let dstPath = cacheDir + '/' + imgName;

  const uuid = UuidUtil.generate();
  let url: string = CommonConstants.BASE_URL + '/files/upload';
  let uploadRequestOptions: request.UploadConfig = {
    url: url,
    header: {
      'Content-Type': ContentType.FORM
    },
    method: RequestMethod.POST,
    files: [{
      filename: imgName,
      name: 'file',
      uri: 'internal://cache/' + imgName,
      type: 'jpg'
    }],
    data: [{
      name: "uuid",
      value: uuid
    }]
  };

  let serverData = new ResponseResult();
  return new Promise((resolve: Function, reject: Function) => {
    try {
      // Copy the URI to the cacheDir directory and upload the file.
      let srcFile = fs.openSync(fileUri);
      let dstFile = fs.openSync(dstPath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      fs.copyFileSync(srcFile.fd, dstFile.fd);
      fs.closeSync(srcFile);
      fs.closeSync(dstFile);

      // Upload the file.
      request.uploadFile(context, uploadRequestOptions).then((data: request.UploadTask) => {
        data.on(UploadingState.COMPLETE, (result: Array<request.TaskState>) => {
          Logger.info('uploadFile success', JSON.stringify(result));
          if (result && result.length >= 1) {
            serverData.code = CommonConstants.SERVER_CODE_SUCCESS;
            serverData.msg = result[0].message;
            serverData.data = `https://nbtbadminton.oss-cn-hangzhou.aliyuncs.com/${uuid}.jpg`
            resolve(serverData);
          }
        });
        data.on(UploadingState.FAIL, (result: Array<request.TaskState>) => {
          Logger.info('uploadFile failed', JSON.stringify(result));
          if (result && result.length >= 1) {
            serverData.msg = $r('app.string.upload_error_message');
            reject(serverData);
          }
        })
      }).catch((err: Error) => {
        Logger.error('uploadFile failed', JSON.stringify(err));
        reject(serverData);
      });
    } catch (err) {
      Logger.error('uploadFile failed', JSON.stringify(err));
      reject(serverData);
    }
  })
}