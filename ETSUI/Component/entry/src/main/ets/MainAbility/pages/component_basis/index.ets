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

const componentBasisItems = [
  { title: 'Button', url: 'pages/component_basis/button/buttonPage' },
  { title: 'Text', url: 'pages/component_basis/text/textPage' },
  { title: 'Span', url: 'pages/component_basis/span/spanPage' },
  { title: 'TextArea', url: 'pages/component_basis/textArea/textAreaPage' },
  { title: "Divider", url: 'pages/component_basis/divider/dividerPage' },
  { title: "QRCode", url: 'pages/component_basis/qrCode/QRCodePage' },
  { title: "Blank", url: 'pages/component_basis/blank/blankPage' },
  { title: "Marquee", url: 'pages/component_basis/marquee/marqueePage' },
  { title: "toggle", url: 'pages/component_basis/toggle/togglePage' },
  { title: "Slider", url: 'pages/component_basis/slider/sliderPage' },
  { title: "Menu", url: 'pages/component_basis/menu/menuPage' },
  { title: "Gauge", url: 'pages/component_basis/gauge/gaugePage' },
  { title: "DataPanel", url: 'pages/component_basis/dataPanel/dataPanelPage' },
  { title: "Progress", url: 'pages/component_basis/progress/progressPage' },
  { title: "TextInput", url: 'pages/component_basis/textInput/textInputPage' },
]

@Entry
@Component
struct component_basis {
  @State basisActive: boolean = false
  @State statusActive: boolean = false
  @State containerActive: boolean = false

  build() {
    Flex({
      direction: FlexDirection.Column,
      alignItems: ItemAlign.Center
    }) {
      List() {
        ForEach(componentBasisItems, (item) => {
          ListItem() {
            Row() {
              Text(item.title)
                .fontSize(16)
                .padding({ left: 10 })

            }
            .padding({ left: 10 })
            .width("100%")
            .height(55)
            .alignItems(VerticalAlign.Center)
            .backgroundColor(0xfff5deb3)
            .margin({ top: 5, bottom: 5 })
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