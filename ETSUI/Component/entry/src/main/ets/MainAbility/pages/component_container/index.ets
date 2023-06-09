/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import router from '@ohos.router'

const componentContainerItems = [

  { title: 'Panel', url: 'pages/component_container/panel/panelPage' },
  { title: 'Navigator', url: 'pages/component_container/navigator/navigatorPage' },
  { title: "Swiper", url: 'pages/component_container/swiper/swiperPage' },
  { title: "Stack", url: 'pages/component_container/stack/stackPage' },
  { title: "Column", url: 'pages/component_container/Column/ColumnPage' },
  { title: "Row", url: 'pages/component_container/row/rowPage' },
  { title: "flex", url: 'pages/component_container/flex/flexPage' },
  { title: "Scroll", url: 'pages/component_container/scroll/scrollPage' },
  { title: "list", url: 'pages/component_container/list/listPage' },
  { title: "Badge", url: 'pages/component_container/badge/badgePage' },
  { title: "tab", url: 'pages/component_container/tab/tabsPage' },
  { title: "Counter", url: 'pages/component_container/Counter/counterPage' },
]

@Entry
@Component
struct component_container {
  @State basisActive: boolean = false
  @State statusActive: boolean = false
  @State containerActive: boolean = false

  build() {
    Flex({
      direction: FlexDirection.Column,
      alignItems: ItemAlign.Center
    }) {
      List() {
        ForEach(componentContainerItems, (item) => {
          ListItem() {
            Row() {
              Text(item.title)
                .fontSize(16)
                .padding({ left: 10 })

            }
            .padding({ left: 10 })
            .width('100%')
            .height(55)
            .alignItems(VerticalAlign.Center)
            .backgroundColor(0xfff5deb3)
            .margin({ top: 5, bottom: 5})
            .borderRadius(12)
            .onClick(() => {
              router.push({
                url: item.url
              })
            })
          }
        }, item => item.title)
      }
      .width('100%')
    }
  }
}
