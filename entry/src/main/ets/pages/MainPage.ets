import { AppStorageKey, FontConstantValue, RequestURIConstantValue, UIConstantValue } from 'constantvalue';
import PageContent from '../components/PageComponent/PageContent';
import { User } from '../type/serviceDataTypes/serviceDataTypes';
import { IMainTabBarDataType } from '../type/uiDataTypes/UIDataType';
import MainTabBarDataViewModel from '../uiDataViewModels/MainTabBarDataViewModel';
import dataPreferences from '@ohos.data.preferences'
import { router } from '@kit.ArkUI';
import { request } from '../request/request';
import { ResponseUserData } from '../type/responseDataTypes/responseDataTypes';
import { AxiosError } from '@ohos/axios';

@Entry
@Component
struct MainPage {
  @State currentSelectedIndex: number = 0;

  @Builder
  tabBarBuilder(tabItem: IMainTabBarDataType, index: number) {
    Column() {
      Image(index === this.currentSelectedIndex ? tabItem.selectedIcon : tabItem.normalIcon)
        .width(UIConstantValue.WIDTH_36)
        .height(UIConstantValue.HEIGHT_36)
        .objectFit(ImageFit.Contain)
      Text(tabItem.tabName)
        .fontSize(FontConstantValue.FONT_SIZE_12)
        .fontColor(index === this.currentSelectedIndex ? $r('app.color.tab_selected_color') :
        $r('app.color.font_color'))
    }
  }

  aboutToAppear(): void {
    // 获取 preferences 对象
    let options: dataPreferences.Options = { name: 'userID' };
    let preferences: dataPreferences.Preferences = dataPreferences.getPreferencesSync(getContext(this), options);
    const userID = preferences.getSync("currentUserID", -1);
    if (userID === -1) {
      router.replaceUrl({
        url: 'pages/HomePage'
      })
      return;
    }
    // 原先已经登录, 查询用户信息进行存储

    request.get<ResponseUserData, ResponseUserData>(RequestURIConstantValue.REQUEST_GET_USER_INFO,
      {
        params: { userID: userID }
      })
      .then((responseData: ResponseUserData) => {
        let responseUser: User = responseData.user;
        if (responseData.requestSuccess && responseUser) {
          AppStorage.setOrCreate<User>(AppStorageKey.CURRENT_LOGIN_USER, responseUser);
          return;
        }
        // 打印日志
        // 提示长时间未登录, 重新登录
        AlertDialog.show({ message: $r('app.string.login_state_expired') })
        return;
      })
      .catch((error: AxiosError) => {
        // 打印错误日志
        AlertDialog.show({ message: JSON.stringify(error, null, 2) })
      })
  }

  hasState(): boolean {
    const user: User | undefined = AppStorage.get<User>(AppStorageKey.CURRENT_LOGIN_USER)
    return user !== undefined && user.state !== 0;
  }

  build() {
    Column() {
      if (MainTabBarDataViewModel.isMineTab(this.currentSelectedIndex)) {
        Row()
          .width('100%')
          .backgroundColor(this.hasState() ? $r('app.color.mine_card_has_state_bkg_color') :
          $r('app.color.mine_card_bkg_color'))
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
          .offset({ x: 0, y: 0.2 })
      }

      Tabs({ barPosition: BarPosition.End, index: $$this.currentSelectedIndex }) {
        ForEach(MainTabBarDataViewModel.getTabBarDataList(), (item: IMainTabBarDataType, index: number) => {
          TabContent() {
            Column() {
              PageContent({
                title: item.tabTitle.valueOf() as string,
                theTabIndex: index
              })
            }
          }
          .tabBar(this.tabBarBuilder(item, index))
          .border({
            width: {
              bottom: UIConstantValue.BORDER_WIDTH_0_5
            },
            color: $r('app.color.border_color')
          })
        },
          (item: IMainTabBarDataType) => item.id.toString())
      }
    }
    .backgroundColor($r('app.color.background_color'))
    .height(UIConstantValue.HEIGHT_PERCENT_100)
    .width(UIConstantValue.WIDTH_PERCENT_100)
    .expandSafeArea([SafeAreaType.SYSTEM],
      MainTabBarDataViewModel.isMineTab(this.currentSelectedIndex) ? [SafeAreaEdge.BOTTOM] :
        [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]) // 区域扩展
  }
}