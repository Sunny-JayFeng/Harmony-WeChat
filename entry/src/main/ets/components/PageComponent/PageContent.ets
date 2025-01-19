import MainTabBarDataViewModel from "../../uiDataViewModels/MainTabBarDataViewModel";
import ContactTabContent from "../ContactTabContent/ContactTabContent";
import TopToolBar from "../TopToolBar";
import WeChatTabContent from "../WeChatTabContent/WeChatTabContent";
import FoundTabContent from "../FoundTabContent/FoundTabContent";
import MineTabContent from "../MineTabContent/MineTabContent";
import UIConstantValue from "constantvalue/src/main/ets/constant/UIConstantValue";

/**
 * 主页面组件：微信、通讯录、发现、我
 */
@Component
export default struct PageContent {
  @Prop theTabIndex: number = 0;
  @Prop title: string = '';

  build() {
    Column() {
      if (!MainTabBarDataViewModel.isMineTab(this.theTabIndex)) {
        TopToolBar({ currentTabTitle: this.title })
          .height(UIConstantValue.HEIGHT_40)
      }
      if (MainTabBarDataViewModel.isWeChatTab(this.theTabIndex)) {
        WeChatTabContent().layoutWeight(UIConstantValue.LAYOUT_WEIGHT_1)
      } else if (MainTabBarDataViewModel.isContactTab(this.theTabIndex)) {
        ContactTabContent().layoutWeight(UIConstantValue.LAYOUT_WEIGHT_1)
      } else if (MainTabBarDataViewModel.isFoundTab(this.theTabIndex)) {
        FoundTabContent().layoutWeight(UIConstantValue.LAYOUT_WEIGHT_1)
      } else if (MainTabBarDataViewModel.isMineTab(this.theTabIndex)) {
        MineTabContent().layoutWeight(UIConstantValue.LAYOUT_WEIGHT_1)
      }
    }
  }
}
