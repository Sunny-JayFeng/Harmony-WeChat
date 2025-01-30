import { User } from "../serviceDataTypes/serviceDataTypes";

export class IResponseData {
  requestSuccess: boolean = false;
  failCode: number = 0;
  failMessage: string = "";

  constructor(requestSuccess: boolean, failCode: number, failMessage: string) {
    this.requestSuccess = requestSuccess;
    this.failCode = failCode;
    this.failMessage = failMessage;
  }
}

export class UploadFilesResponseData extends IResponseData {
  uploadFileNameList: string[];

  constructor(requestSuccess: boolean, failCode: number, failMessage: string, uploadFileNameList: string[]) {
    super(requestSuccess, failCode, failMessage);
    this.uploadFileNameList = uploadFileNameList;
  }
}

export class ResponseUserData extends IResponseData {
  user: User

  constructor(requestSuccess: boolean, failCode: number, failMessage: string, user: User) {
    super(requestSuccess, failCode, failMessage);
    this.user = user
  }
}