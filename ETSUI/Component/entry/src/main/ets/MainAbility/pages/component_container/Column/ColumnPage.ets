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
struct ColumnPage {
  @State num1: number[] = [...Array(3).keys()]
  @State num2: number[] = [...Array(4).keys()]
  @State alignItemsId: number = 0
  @State alignItems: HorizontalAlign[] = [HorizontalAlign.Start, HorizontalAlign.Center, HorizontalAlign.End]
  @State alignItemsDescribe: string[] = ['Start', 'Center', 'End']
  @State space: number = 0
  @State useAlign: string = 'Start'
  @State flexItemsId: number = 0
  @State flexItems: FlexAlign[] = [FlexAlign.Center, FlexAlign.Start, FlexAlign.End]
  @State flexItemsDescribe: string[] = ['Center', 'Start', 'End']
  @State flexAlign: string = 'Top'

  build() {
    Column() {
      Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
          Column({ space: this.space }) {
            Row() {
            }.width(50).height(50).backgroundColor(Color.Orange)

            Row() {
            }.width(50).height(50).backgroundColor(Color.Yellow)
          }
          .width(300)
          .height(300)
          .border({ width: 1 })
          .alignItems(this.alignItems[this.alignItemsId])

          Column({ space: this.space }) {
            Row() {
            }.width(50).height(50).backgroundColor(Color.Orange)

            Row() {
            }.width(50).height(50).backgroundColor(Color.Yellow)
          }
          .width(300)
          .height(300)
          .border({ width: 1 })
          .justifyContent(this.flexItems[this.flexItemsId])
      }
      .height('40%')
      .width('100%')
      .border({ width: 5, color: Color.Orange, radius: 10, style: BorderStyle.Dotted })

      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceAround }) {
        Grid() {
          GridItem() {
            Text('对齐方式')
              .fontSize(15)
              .backgroundColor(0xFAEEE0)
              .height(40)
              .width('100%')
              .textAlign(TextAlign.Start)
              .margin({ left: 20 })
              .fontWeight(FontWeight.Bolder)
          }.columnStart(0).columnEnd(3).forceRebuild(true)

          ForEach(this.num1, item => {
            GridItem() {
              Button(this.alignItemsDescribe[`${item}`])
                .fontSize(15)
                .width('100%')
                .onClick(() => {
                  this.alignItemsId = item
                })
            }
          }, item => item.toString())
          GridItem() {
            Text(`space：${this.space}`)
              .fontSize(15)
              .backgroundColor(0xFAEEE0)
              .width('100%')
              .height(40)
              .textAlign(TextAlign.Start)
              .margin({ left: 20 })
              .fontWeight(FontWeight.Bolder)
          }.columnStart(0).columnEnd(3).forceRebuild(true)

          GridItem() {
            Slider({ value: this.space, step: 1, min: -10, max: 50 })
              .blockColor(Color.Orange)
              .width('100%')
              .onChange((e) => {
                this.space = Math.round(e)
              })
          }.columnStart(0).columnEnd(3).forceRebuild(true)

          GridItem() {
            Text('自定义纵向对齐方式')
              .fontSize(15)
              .backgroundColor(0xFAEEE0)
              .width('100%')
              .height(40)
              .textAlign(TextAlign.Start)
              .margin({ left: 20 })
              .fontWeight(FontWeight.Bolder)
          }.columnStart(0).columnEnd(3).forceRebuild(true)

          ForEach(this.num1, item => {
            GridItem() {
              Button(this.flexItemsDescribe[`${item}`])
                .fontSize(15)
                .width('100%')
                .onClick(() => {
                  this.flexItemsId = item
                })
            }
          }, item => item.toString())
        }
        .columnsTemplate('1fr 1fr 1fr 1fr')
        .rowsTemplate("")
        .columnsGap(5)
        .rowsGap(5)
        .scrollBar(BarState.Auto)
        .margin({bottom:10})
      }.height('60%')
      .width('100%')
      .margin({ top: 10 })
    }
    .width('100%').margin({ top: 5})
  }
}