import FontConstantValue from 'constantvalue/src/main/ets/constant/FontConstantValue';
import UIConstantValue from 'constantvalue/src/main/ets/constant/UIConstantValue';
import { ContactDataType, IContactListDataType } from '../../type/uiDataTypes/UIDataType';
import ContactListDataViewModel from '../../uiDataViewModels/contact/ContactListDataViewModel';
import ContactItem from './ContactItem';

@Component
export default struct ContactTabContent {
  private readonly contactDataList: IContactListDataType[] = [
    ContactListDataViewModel.getContactClassifyData(),
    ContactListDataViewModel.getEnterpriseClassifyData()
  ];

  @Builder
  groupHeader(text: string) {
    if (text) {
      Text(text)
        .fontSize(FontConstantValue.FONT_SIZE_10)
        .fontColor('#979797')
        .padding(UIConstantValue.PADDING_10)
    }
  }

  build() {
    List() {
      ForEach(this.contactDataList, (dataItem: IContactListDataType, index: number) => {
        ListItemGroup({ header: this.groupHeader(dataItem.classifyName) }) {
          ForEach(dataItem.dataList, (data: ContactDataType, index: number) => {
            ContactItem({
              contactAvatarImg: data.avatarImg,
              contactName: data.contactName
            })
          }, (data: ContactDataType) => data.id.toString())
        }
      }, (index: number) => index.toString())
    }
    .width(UIConstantValue.WIDTH_PERCENT_100)
    .height(UIConstantValue.HEIGHT_PERCENT_100)
  }
}