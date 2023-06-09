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

import Logger from '../model/Logger'
import { NetworkMobile } from '../model/NetworkMobile'

const TAG: string = '[NetWork]'

@Extend(Text) function simId () {
  .margin(5)
  .fontSize(20)
  .width('40%')
  .textAlign(TextAlign.Center)
  .borderRadius(10)
}

@Component
export struct NetWork {
  @State slotId: number = -1
  @State cellularData: boolean = false
  @State cellularDataRoaming: boolean = false
  private netWorkMobile: NetworkMobile = new NetworkMobile()

  async aboutToAppear() {
    try {
      this.slotId = await this.netWorkMobile.getDefaultCellularDataSlotId()
      Logger.info(TAG, `this slotid = ${this.slotId}`)
    } catch (err) {
      Logger.info(TAG, `this slotid get is faile err = ${JSON.stringify(err)}`)
    }
    try {
      this.cellularData = await this.netWorkMobile.isCellularDataEnabled()
      Logger.info(TAG, `this cellularData = ${this.cellularData}`)
    } catch (err) {
      Logger.info(TAG, `this cellularData get is faile err = ${JSON.stringify(err)}`)
    }
    try {
      this.cellularDataRoaming = await this.netWorkMobile.isCellularDataRoamingEnabled(this.slotId)
      Logger.info(TAG, `this cellularDataRoaming = ${this.cellularDataRoaming}`)
    } catch (err) {
      Logger.info(TAG, `this cellularDataRoaming get is faile err = ${JSON.stringify(err)}`)
    }
  }

  @Builder dataState(text: Resource, flag: boolean) {
    Row() {
      Text(text)
        .margin({ left: 10 })
        .fontSize(20)
        .width('55%')
        .textAlign(TextAlign.Start)

      Text(flag === true ? $r('app.string.start') : $r('app.string.end'))
        .fontSize(20)
        .margin({ left: 10, right: 6 })
        .textAlign(TextAlign.Center)
        .layoutWeight(1)
    }
    .margin(10)
    .height('8%')
  }

  build() {
    Column() {
      Row() {
        Text($r('app.string.sim'))
          .margin({ left: 10 })
          .fontSize(20)
          .width('60%')
          .textAlign(TextAlign.Start)
        Row() {
          Text($r('app.string.simOne'))
            .simId()
            .backgroundColor(this.slotId === 0 ? '#0D9FFB' : undefined)

          Text($r('app.string.simTwo'))
            .simId()
            .backgroundColor(this.slotId === 1 ? '#0D9FFB' : undefined)
        }
        .width('35%')
        .borderRadius(10)
        .backgroundColor('#fff5f5f5')
      }
      .height('8%')
      .margin({ right: 10, bottom: 10 })

      Divider()

      this.dataState($r('app.string.mobile'), this.cellularData)

      Divider()

      this.dataState($r('app.string.roaming'), this.cellularDataRoaming)
    }
    .width('100%')
    .height('100%')
  }
}