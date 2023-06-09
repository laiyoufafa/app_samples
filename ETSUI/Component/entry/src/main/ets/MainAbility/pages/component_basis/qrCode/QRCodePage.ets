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

@Entry
@Component
struct QRCodePage {
  @State value: string = ''
  @State temporary: string = ''
  @State color: Color = Color.Black
  build() {
    Column(){
      Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
        QRCode(this.value)
          .color(this.color)
      }
      .height('40%')
      .width('100%')
      .border({ width: 5, color: Color.Orange, radius: 10, style: BorderStyle.Dotted })

      Column(){
        Row(){
          Text('二维码内容：')
            .fontSize(15)
            .backgroundColor(0xFAEEE0)
            .width('30%')
            .height(40)
            .textAlign(TextAlign.Start)
            .fontWeight(FontWeight.Bolder)
          Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceAround }) {
            TextInput({placeholder: '', text: this.temporary })
              .enterKeyType(EnterKeyType.Send)
              .placeholderFont({size:15})
              .height(40)
              .border({width:3,radius:20,color:'#88000000'})
              .onChange((value)=>{
                this.temporary = value
              })
              .onSubmit(()=>{
                this.value = this.temporary
                this.temporary = ''
              })
          }
          .width('70%')
          .margin({ top: 5, bottom: 5 ,left:10,right:10})
        }
        Text('二维码颜色：')
          .fontSize(15)
          .backgroundColor(0xFAEEE0)
          .width('100%')
          .height(40)
          .textAlign(TextAlign.Start)
          .fontWeight(FontWeight.Bolder)
        Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Start }) {
          Button('Red')
            .margin({right:10})
            .fontSize(15)
            .width(90)
            .onClick(() => {
              this.color = Color.Red
            })
          Button('Yellow')
            .margin({right:10})
            .fontSize(15)
            .width(90)
            .onClick(() => {
              this.color = Color.Yellow
            })
          Button('Green')
            .margin({right:2})
            .fontSize(15)
            .width(90)
            .onClick(() => {
              this.color = Color.Green
            })
          Button('Blue')
            .margin({right:10})
            .fontSize(15)
            .width(90)
            .onClick(() => {
              this.color = Color.Blue
            })
        }
        .width('100%')
        .margin({ top: 5, bottom: 5 ,left:10,right:10})
      }.alignItems(HorizontalAlign.Start)
      .margin({ top: 20 })

    }.width('100%')
  }
}