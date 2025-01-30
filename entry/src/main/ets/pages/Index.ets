import { photoAccessHelper } from '@kit.MediaLibraryKit';
import fileIo from '@ohos.file.fs';
import fs from '@ohos.file.fs'
import { image } from '@kit.ImageKit';
import axios, { AxiosError, AxiosProgressEvent, AxiosResponse, FormData } from '@ohos/axios';
import { User } from '../type/serviceDataTypes/serviceDataTypes';
import { UploadFilesResponseData } from '../type/responseDataTypes/responseDataTypes';
import { request } from '../request/request';

@Entry
@Component
struct Index {
  @State filePath: string = '';

  async uploadFile() {

    // 选择相册的文件
    const photoPicker = new photoAccessHelper.PhotoViewPicker()
    const pickerRes = await photoPicker.select({
      MIMEType: photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE,
      maxSelectNumber: 1
    })
    const photoUri = pickerRes.photoUris[0]
    const photoFile = fs.openSync(photoUri, fs.OpenMode.READ_ONLY);
    // 将选择的文件拷贝到沙箱 cache
    let newPath = getContext(this).cacheDir + '/' + photoFile.name;
    fs.copyFileSync(photoFile.fd, newPath);

    // 构建数据
    let formData = new FormData();
    let realFileUri = 'internal://cache/' + photoFile.name;
    formData.append('files', realFileUri);

    // 发起上传请求
    request.post<UploadFilesResponseData, UploadFilesResponseData, FormData>('/file/uploadAvatarFile',
      formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
          'request-from': 'harmony-application'
        },
        context: getContext(this),
        onUploadProgress: (progressEvent: AxiosProgressEvent): void => {
          console.log('uploadFile,文件上传中')
        },
      })
      .then((result: UploadFilesResponseData) => {
        AlertDialog.show({ message: JSON.stringify(result, null, 2) })
        // AlertDialog.show({ message: JSON.stringify(result.responseData.uploadFileNameList, null, 2) })
      })
      .catch((error: AxiosError) => {
        AlertDialog.show({ message: JSON.stringify(error, null, 2) })
      })
  }

  testRegister() {
    let user: User = new User();
    user.account = 'dolphin';
    user.password = 'dolphin';
    user.phoneNumber = '180****6783';
    user.userName = '小海豚';
    request.post<string, AxiosResponse<string>, User>('http://192.168.56.1:8888/wechat/user/register', user, {
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'request-from': 'harmony-application'
      },
      context: getContext(this)
    }).then((result: AxiosResponse<string>) => {
      AlertDialog.show({ message: JSON.stringify(result, null, 2) })
    }).catch((error: AxiosError) => {
      AlertDialog.show({ message: JSON.stringify(error, null, 2) })
    })
  }

  build() {
    Column({ space: 10 }) {
      Button('上传文件').onClick(() => {
        this.uploadFile()
      })
      Button('注册').onClick(() => {
        this.testRegister();
      })
    }
  }
}