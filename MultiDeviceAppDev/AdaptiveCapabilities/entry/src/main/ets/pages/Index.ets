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
import Logger from '../model/Logger'

const directory = [
  { title: $r('app.string.resource_qualifier'), uri: "pages/resourceQualifier/ResourceQualifier" },
  { title: $r('app.string.atomic_capability'), uri: "pages/atomicLayoutCapability/AtomicLayoutCapabilityIndex" },
  { title: $r('app.string.responsive_layout'), uri: "pages/responsiveLayout/ResponsiveLayoutIndex" },
]

@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller()
  @State inSetValue: number = 40

  build() {
    Column() {
      Scroll(this.scroller) {
        Column() {
          Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
            Text($r('app.string.home_title'))
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .height(100)

          List({ space: 5, initialIndex: 1 }) {
            ForEach(directory, (item) => {
              ListItem() {
                Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Center }) {
                  Text(item.title)
                    .fontSize(20)
                    .padding({ left: 20 })
                }
              }
              .backgroundColor('#66CCFF')
              .width('100%')
              .height(80)
              .borderRadius(10)
              .onClick(() => {
                Logger.info('[Index]', `${item.uri}`)
                router.push({
                  url: item.uri
                })
              })
            }, item => item.uri)
          }
          .listDirection(Axis.Vertical)
          .divider({ strokeWidth: 1, color: Color.White, startMargin: 10 })
          .width('98%')
        }
        .width('100%')
      }
      .padding(10)
      .scrollBar(BarState.Off)
    }.width('100%').height('100%')
  }
}