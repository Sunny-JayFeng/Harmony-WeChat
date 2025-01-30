export default class RequestURIConstantValue {
  static readonly REQUEST_BASE_URL: string = 'http://192.168.56.1:8888/wechat';
  static readonly UPLOAD_AVATAR_FILE_URI: string = '/file/uploadAvatarFile';
  static readonly REQUEST_AVATAR_IMG_URI:string = 'http://192.168.56.1:8888/wechat/resources/avatar/';
  static readonly REQUEST_REGISTER_USER:string = '/user/register';
  static readonly REQUEST_GET_USER_INFO:string = '/user/getUserInfo'
  static readonly REQUEST_LOGIN_BY_PHONE_AND_VERIFY_CODE:string = '/user/loginByPhoneAndVerifyCode'
  static readonly REQUEST_LOGIN_BY_ACCOUNT_AND_PASSWORD:string = '/user/loginByAccountAndPassword'
  static readonly REQUEST_LOGIN_BY_PHONE_AND_PASSWORD:string = '/user/loginByPhoneAndPassword'
}