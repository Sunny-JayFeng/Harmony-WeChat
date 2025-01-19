import ChartItem from "./ChatItem"

@Component
export default struct WeChatTabContent {
  build() {
    Column() {
      ChartItem({
        chatItemData: {
          imgUrl: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg9.doubanio.com%2Fview%2Fgroup_topic%2Fl%2Fpublic%2Fp406625096.jpg&refer=http%3A%2F%2Fimg9.doubanio.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1739200275&t=3924403d9b2a7a66ae49298a67c64690',
          title: '文件传输助手',
          latestMessageTime: '17:28',
          latestMessage: '天气很好',
          isTop: true
        }
      })
      ChartItem({
        chatItemData: {
          imgUrl: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg9.doubanio.com%2Fview%2Fgroup_topic%2Fl%2Fpublic%2Fp406625096.jpg&refer=http%3A%2F%2Fimg9.doubanio.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1739200275&t=3924403d9b2a7a66ae49298a67c64690',
          title: '文件传输助手',
          latestMessageTime: '17:28',
          latestMessage: '天气很好',
          isTop: true
        }
      })
      ChartItem({
        chatItemData: {
          imgUrl: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg9.doubanio.com%2Fview%2Fgroup_topic%2Fl%2Fpublic%2Fp406625096.jpg&refer=http%3A%2F%2Fimg9.doubanio.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1739200275&t=3924403d9b2a7a66ae49298a67c64690',
          title: '文件传输助手',
          latestMessageTime: '17:28',
          latestMessage: '天气很好',
          isTop: true
        }
      })
    }
  }
}