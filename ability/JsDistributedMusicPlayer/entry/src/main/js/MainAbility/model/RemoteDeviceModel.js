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

import deviceManager from '@ohos.distributedHardware.deviceManager';

var SUBSCRIBE_ID = 100;

export default class RemoteDeviceModel {
    deviceList = [];
    discoverList = [];
    callback;
    authCallback = null;
    #deviceManager;

    constructor() {
    }

    registerDeviceListCallback(callback) {
        if (typeof (this.#deviceManager) === 'undefined') {
            console.log('MusicPlayer[RemoteDeviceModel] deviceManager.createDeviceManager begin');
            deviceManager.createDeviceManager('com.ohos.distributedmusicplayer', (error, value) => {
                if (error) {
                    console.error('createDeviceManager failed.');
                    return;
                }
                this.#deviceManager = value;
                this.registerDeviceListCallback_(callback);
                console.log('MusicPlayer[RemoteDeviceModel] createDeviceManager callback returned, error=' + error + ' value=' + value);
            });
            console.log('MusicPlayer[RemoteDeviceModel] deviceManager.createDeviceManager end');
        } else {
            this.registerDeviceListCallback_(callback);
        }
    }

    registerDeviceListCallback_(callback) {
        console.info('MusicPlayer[RemoteDeviceModel] registerDeviceListCallback');
        this.callback = callback;
        if (this.#deviceManager == undefined) {
            console.error('MusicPlayer[RemoteDeviceModel] deviceManager has not initialized');
            this.callback();
            return;
        }

        console.info('MusicPlayer[RemoteDeviceModel] getTrustedDeviceListSync begin');
        var list = this.#deviceManager.getTrustedDeviceListSync();
        console.info('MusicPlayer[RemoteDeviceModel] getTrustedDeviceListSync end, deviceList=' + JSON.stringify(list));
        if (typeof (list) != 'undefined' && typeof (list.length) != 'undefined') {
            this.deviceList = list;
        }
        this.callback();
        console.info('MusicPlayer[RemoteDeviceModel] callback finished');
        
        this.#deviceManager.on('deviceStateChange', (data) => {
            console.info('MusicPlayer[RemoteDeviceModel] deviceStateChange data=' + JSON.stringify(data));
            switch (data.action) {
                case 0:
                this.deviceList[this.deviceList.length] = data.device;
                console.info('MusicPlayer[RemoteDeviceModel] online, updated device list=' + JSON.stringify(this.deviceList));
                this.callback();
                if (this.authCallback != null) {
                    this.authCallback();
                    this.authCallback = null;
                }
                break;
                case 2:
                if (this.deviceList.length > 0) {
                    for (var i = 0; i < this.deviceList.length; i++) {
                        if (this.deviceList[i].deviceId === data.device.deviceId) {
                            this.deviceList[i] = data.device;
                            break;
                        }
                    }
                }
                console.info('MusicPlayer[RemoteDeviceModel] change, updated device list=' + JSON.stringify(this.deviceList));
                this.callback();
                break;
                case 1:
                if (this.deviceList.length > 0) {
                    var list = [];
                    for (var i = 0; i < this.deviceList.length; i++) {
                        if (this.deviceList[i].deviceId != data.device.deviceId) {
                            list[i] = data.device;
                        }
                    }
                    this.deviceList = list;
                }
                console.info('MusicPlayer[RemoteDeviceModel] offline, updated device list=' + JSON.stringify(data.device));
                this.callback();
                break;
                default:
                    break;
            }
        });
        this.#deviceManager.on('deviceFound', (data) => {
            console.info('MusicPlayer[RemoteDeviceModel] deviceFound data=' + JSON.stringify(data));
            console.info('MusicPlayer[RemoteDeviceModel] deviceFound this.deviceList=' + this.deviceList);
            console.info('MusicPlayer[RemoteDeviceModel] deviceFound this.deviceList.length=' + this.deviceList.length);
            for (var i = 0; i < this.discoverList.length; i++) {
                if (this.discoverList[i].deviceId === data.device.deviceId) {
                    console.info('MusicPlayer[RemoteDeviceModel] device founded, ignored');
                    return;
                }
            }
            this.discoverList[this.discoverList.length] = data.device;
            this.callback();
        });
        this.#deviceManager.on('discoverFail', (data) => {
            console.info('MusicPlayer[RemoteDeviceModel] discoverFail data=' + JSON.stringify(data));
        });
        this.#deviceManager.on('serviceDie', () => {
            console.error('MusicPlayer[RemoteDeviceModel] serviceDie');
        });

        SUBSCRIBE_ID = Math.floor(65536 * Math.random());
        var info = {
            subscribeId: SUBSCRIBE_ID,
            mode: 0xAA,
            medium: 2,
            freq: 2,
            isSameAccount: false,
            isWakeRemote: true,
            capability: 0
        };
        console.info('MusicPlayer[RemoteDeviceModel] startDeviceDiscovery ' + SUBSCRIBE_ID);
        this.#deviceManager.startDeviceDiscovery(info);
    }

    authDevice(deviceId, callback) {
        console.info('MusicPlayer[RemoteDeviceModel] authDevice ' + deviceId);
        for (var i = 0; i < this.discoverList.length; i++) {
            if (this.discoverList[i].deviceId === deviceId) {
                console.info('MusicPlayer[RemoteDeviceModel] device founded, ignored');
                let extraInfo = {
                    "targetPkgName": 'ohos.samples.distributedmusicplayer',
                    "appName": 'Music',
                    "appDescription": 'Music player application',
                    "business": '0'
                };
                let authParam = {
                    "authType": 1,
                    "appIcon": '',
                    "appThumbnail": '',
                    "extraInfo": extraInfo
                };
                console.info('MusicPlayer[RemoteDeviceModel] authenticateDevice ' + JSON.stringify(this.discoverList[i]));
                this.#deviceManager.authenticateDevice(this.discoverList[i], authParam, (err, data) => {
                    if (err) {
                        console.info('MusicPlayer[RemoteDeviceModel] authenticateDevice failed, err=' + JSON.stringify(err));
                        this.authCallback = null;
                    } else {
                        console.info('MusicPlayer[RemoteDeviceModel] authenticateDevice succeed, data=' + JSON.stringify(data));
                        this.authCallback = callback;
                    }
                });
            }
        }
    }

    unregisterDeviceListCallback() {
        console.info('MusicPlayer[RemoteDeviceModel] stopDeviceDiscovery ' + SUBSCRIBE_ID);
        if(typeof (this.#deviceManager) === 'undefined'){
            return
        }
        this.#deviceManager.stopDeviceDiscovery(SUBSCRIBE_ID);
        this.#deviceManager.off('deviceStateChange');
        this.#deviceManager.off('deviceFound');
        this.#deviceManager.off('discoverFail');
        this.#deviceManager.off('serviceDie');
        this.deviceList = [];
    }
}