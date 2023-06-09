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

import prompt from '@ohos.prompt';

@Entry
@Component
struct StackPage {
  @State num: number[] = [...Array(9).keys()]
  @State alignContentId: number = 0
  @State alignContent: Alignment[] = [Alignment.TopStart, Alignment.Top, Alignment.TopEnd, Alignment.Start, Alignment.Center, Alignment.End, Alignment.BottomStart, Alignment.Bottom, Alignment.BottomEnd]
  @State alignContentDescribe: string[] = ['TopStart', 'Top', 'TopEnd', 'Start', 'Center', 'End', 'BottomStart', 'Bottom', 'BottomEnd']

  build() {
    Column() {
      Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
        Stack({ alignContent: this.alignContent[this.alignContentId] }) {
          Image($r('app.media.test'))
            .width(320)
            .height(340)
            .objectFit(ImageFit.Contain)
        }.width('100%')
        .height('100%')
      }
      .height('40%')
      .width('100%')
      .border({ width: 5, color: Color.Orange, radius: 10, style: BorderStyle.Dotted })

      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceAround }) {
        Grid() {
          GridItem() {
            Text('可滑动面板类型：')
              .fontSize(15)
              .height(40)
              .backgroundColor(0xFAEEE0)
              .fontWeight(FontWeight.Bolder)
              .width('100%')
              .margin({ left: 5 })
          }.columnStart(0).columnEnd(4).forceRebuild(true)

          ForEach(this.num, item => {
            GridItem() {
              Button(this.alignContentDescribe[`${item}`])
                .fontSize(15)
                .width('100%')
                .onClick(() => {
                  this.alignContentId = item
                })
            }
          }, item => item.toString())
        }
        .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
        .rowsTemplate("")
        .columnsGap(5)
        .rowsGap(5)
        .scrollBar(BarState.Auto)
      }
      .margin({ top: 10 })
      .height('60%')
      .width('100%')
    }
    .width('100%').margin({ top: 5 })
  }
}