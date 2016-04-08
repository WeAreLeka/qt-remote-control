import QtQuick 2.3
import QtBluetooth 5.3
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2


Item {
    id: scanner;
    property BluetoothService service

    signal selected(BluetoothService remoteService)


    MessageDialog {
        id: errorDialog
        title: qsTr("Error")
        icon: StandardIcon.Critical
        standardButtons: StandardButton.Ok

    }

    MessageDialog {
        id: connectDialog
        title: qsTr("Connect with...")
        icon: StandardIcon.Question
        standardButtons: StandardButton.Ok | StandardButton.Cancel
        onAccepted: {
            console.debug("Device selected: UUID:",scanner.service.serviceUuid + "Name: " +scanner.service.serviceName)
            scanner.selected(scanner.service)
            stackView.push({item:mainView, immediate: true, replace: true})
        }
        onRejected: {
            console.debug("Device no selected")
        }

    }

    BluetoothDiscoveryModel {
        id: btModel
        running: true
        //discoveryMode: BluetoothDiscoveryModel.DeviceDiscovery
        //discoveryMode: BluetoothDiscoveryModel.MinimalServiceDiscovery
        discoveryMode: BluetoothDiscoveryModel.FullServiceDiscovery

        onDiscoveryModeChanged: console.log("Discovery mode: " + discoveryMode)
        onServiceDiscovered: console.log("Found new service " + service.deviceAddress + " " + service.deviceName + " " + service.serviceName)
        onDeviceDiscovered: console.log("New device: " + device)
        onRunningChanged: {
            if (btModel.running == false) {
                animation.complete()
                animation.running = false
            }
        }

        onErrorChanged: {
            switch (btModel.error) {
            case BluetoothDiscoveryModel.PoweredOffError:
                console.log("Error: Bluetooth device not turned on")
                errorDialog.text = "Bluetooth device not turned on"
                errorDialog.open()
                break
            case BluetoothDiscoveryModel.InputOutputError:
                console.log("Error: Bluetooth I/O Error")
                errorDialog.text = "Bluetooth I/O Error"
                errorDialog.open()
                break
            case BluetoothDiscoveryModel.InvalidBluetoothAdapterError:
                console.log("Error: Invalid Bluetooth Adapter Error")
                errorDialog.text = "Invalid Bluetooth Adapter Error"
                errorDialog.open()
                break
            case BluetoothDiscoveryModel.NoError:
                break;
            default:
                console.log("Error: Unknown Error")
                errorDialog.text = "Unknown Error"
                errorDialog.open()
                break
            }
        }
        //uuidFilter: "00001101-0000-1000-8000-00805f9b34fb"
    }

    Rectangle {
        id: busy
        color: "#56AED4"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        height: parent.height * 0.1
        z: 2

        ImgButton {
            id: reloadButton

            imgSrc: btModel.running?"reload.svg":"refresh.svg"
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.top: parent.top
            width: height

            RotationAnimation on rotation {
                id: animation
                running: true
                loops: Animation.Infinite
                from: 0
                to: 360
                duration: 1200
            }

            onClicked: {
                console.debug("Reload BT scannig.")
                animation.running = true
                //btModel.discoveryMode = BluetoothDiscoveryModel.MinimalServiceDiscovery
                btModel.discoveryMode = BluetoothDiscoveryModel.FullServiceDiscovery
                //btModel.discoveryMode = BluetoothDiscoveryModel.DeviceDiscovery
                btModel.running = true
            }
        }

        ImgButton {
            id: backButton
            imgSrc: "backButton.svg"
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.01
            height: parent.height * 0.6
            anchors.verticalCenter: parent.verticalCenter
            width: height
            visible: stackView.currentItem == scanner?true:false
            onClicked: {
                console.debug("Reload BT scannig.")
                stackView.push({item:mainView, immediate: true, replace: true})
            }
        }

    }

    ListView {
        id: scanList
        anchors.top: busy.bottom
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        spacing: 30
        currentIndex: -1
        model: btModel
        focus: true
        z: 1

        delegate: Item{
            visible: stackView.currentItem == scanner?true:false
            width: scanner.width > 1000? parent.width * 0.6:parent.width * 0.95
            anchors.horizontalCenter: parent.horizontalCenter
            height: 125
            Rectangle {
                anchors.fill: parent
                color: "white"
                Rectangle {
                    anchors.bottom: parent.bottom
                    height: 2
                    width: parent.width
                    color: "#b9b9b9"
                }
                Rectangle {
                    anchors.right: parent.right
                    height: parent.height
                    width: 3
                    color: "#b9b9b9"
                }
            }

            ImgButton {
                id: btDevButton
                imgSrc: "btScanButton.png"
                ColorOverlay {
                    anchors.fill: btDevButton
                    source: btDevButton
                    color: "green"

                    visible: {
                        if (socket.connected) {
                            if (socket.service.deviceName == model.name) {
                                return true;
                            }
                            else {
                                return false;
                            }
                        } else
                            return false;
                    }
                }
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height * 0.5
                width: height * 0.7
            }

            Text {
                id: bttext
                text: deviceName ? deviceName : name
                font.family: customFont.name
                font.pointSize: 24
                color: "#EB1C6A"
                anchors.left: btDevButton.right
                anchors.leftMargin: 60
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                id: details
                function get_details(s) {
                    if (btModel.discoveryMode == BluetoothDiscoveryModel.DeviceDiscovery) {
                        //We are doing a device discovery
                        var str = "Address: " + remoteAddress;
                        return str;
                    }
                    else if (btModel.discoveryMode == BluetoothDiscoveryModel.MinimalServiceDiscovery){
                    var str = "Address: " + remoteAddress;
                    if (s.serviceName) { str += "<br>Service: " + s.serviceName; }
                    return str;
                } else

                    {
                        //var str = "Address: " + s.deviceAddress;
                        if (s.serviceName) { str += "<br>Service: " + s.serviceName; }
                        //if (s.serviceDescription) { str += "<br>Description: " + s.serviceDescription; }
                        //if (s.serviceProtocol) { str += "<br>Protocol: " + s.serviceProtocol; }
                        return str;
                    }
                }
                text: get_details(service)
                font.pointSize: 24
                font.family: customFont.name
                anchors.left: bttext.right
                anchors.leftMargin: 60
                color: "#EB1C6A"
                anchors.verticalCenter: parent.verticalCenter
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    connectDialog.text = model.name
                    scanner.service = model.service
                    connectDialog.open()
                }
            }
        }
    }
    ScrollBar {
        flickable: scanList;
        z: 3
    }
}

