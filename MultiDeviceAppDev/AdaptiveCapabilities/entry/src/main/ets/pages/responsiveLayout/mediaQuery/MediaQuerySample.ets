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
import mediaquery from '@ohos.mediaquery'

@Entry
@Component
struct MediaQuerySample {
  @State color: string = '#DB7093'
  @State text: Resource = $r('app.string.portrait')
  @State flag: boolean = false
  private listener: mediaquery.MediaQueryListener = mediaquery.matchMediaSync('(orientation: landscape)')
  onOrientationChange = (mediaQueryResult) => {
    if (mediaQueryResult.matches) {
      this.color = '#FFD700'
      this.text = $r('app.string.landscape')
      this.flag = true
    } else {
      this.color = '#DB7093'
      this.text = $r('app.string.portrait')
      this.flag = false
    }
  }

  aboutToAppear() {
    this.listener.on('change', this.onOrientationChange);
  }

  aboutToDisappear() {
    this.listener.off('change', this.onOrientationChange);
  }

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      if (this.flag) {
        Image($r('app.media.my_image'))
          .width(100)
          .height(100)
      }
      Text(this.text)
        .fontSize(24)
        .fontColor(this.color)
    }
    .width('100%')
    .height('100%')
  }
}