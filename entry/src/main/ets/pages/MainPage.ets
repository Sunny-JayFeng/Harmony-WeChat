import { FontConstantValue, UIConstantValue } from 'constantvalue';
import PageContent from '../components/PageComponent/PageContent';
import { IMainTabBarDataType } from '../uiDataTypes/UIDataType';
import MainTabBarDataViewModel from '../uiDataViewModels/MainTabBarDataViewModel';
import MineContentListDataViewModel from '../uiDataViewModels/mine/MineContentListDataViewModel';

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

  build() {
    Column() {
      if (MainTabBarDataViewModel.isMineTab(this.currentSelectedIndex)) {
        Row()
          .width('100%')
          .backgroundColor(MineContentListDataViewModel.hasState() ? $r('app.color.mine_card_has_state_bkg_color') :
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