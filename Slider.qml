import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtBluetooth 5.3
import QtQuick.Controls.Styles 1.4

Item {
    id: sliders

    signal sendBt(int leftMotor, int rightMotor)
    onSendBt: {
        // add 0 and sign before int
        // for motor left
        if (leftMotor < 100 && leftMotor >= 10)
            leftMotor = "+0"+leftMotor
        else if (leftMotor > -100 && leftMotor <= -10)
            leftMotor = "-0"+Math.abs(leftMotor)
        else if (leftMotor == 0)
            leftMotor = "+000"
        else if (leftMotor < 10 && leftMotor > 0)
            leftMotor = "+00"+leftMotor
        else if (leftMotor > -10 && leftMotor < 0)
            leftMotor = "-00"+Math.abs(leftMotor)
        else if (leftMotor >= 100)
            leftMotor = "+"+leftMotor
        else if (leftMotor <= -100)
            leftMotor = leftMotor

        // for motor right
        if (rightMotor < 100 && rightMotor >= 10)
            rightMotor = "+0"+rightMotor
        else if (rightMotor > -100 && rightMotor <= -10)
            rightMotor = "-0"+Math.abs(rightMotor)
        else if (rightMotor == 0)
            rightMotor = "+000"
        else if (rightMotor < 10 && rightMotor > 0)
            rightMotor = "+00"+rightMotor
        else if (rightMotor > -10 && rightMotor < 0)
            rightMotor = "-00"+Math.abs(rightMotor)
        else if (rightMotor >= 100)
            rightMotor = "+"+rightMotor
        else if (leftMotor <= -100)
            rightMotor = rightMotor

        /*            if (rightMotor < 100 && rightMotor > 9)
            rightMotor = ["0", rightMotor].join()
        if (rightMotor < 10 && rightMotor > 0)
            rightMotor = ["00", rightMotor].join()
*/
        console.debug("leftMotor: "+leftMotor+"   rightMotor: "+rightMotor)
        socket.sendStringData("["+leftMotor+","+rightMotor+",000,000,000,000,000,000]")
    }

    visible: true
    height: parent.parent.height * 0.9
    width: parent.parent.width
    Slider {
        id: sliderVertical1
        minimumValue: -255
        maximumValue: 255
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: parent.width * 0.1
        anchors.topMargin: parent.height * 0.1
        width: 200
        onValueChanged: {
            parent.sendBt(sliderVertical1.value, sliderVertical2.value)
        }

        orientation: Qt.Vertical
        style: SliderStyle {
            groove: Rectangle {
                implicitWidth: 200
                implicitHeight: 8
                color: "gray"
                radius: 8
            }
            handle: Rectangle {
                anchors.centerIn: parent
                color: control.pressed ? "white" : "lightgray"
                border.color: "gray"
                border.width: 2
                implicitWidth: 34
                implicitHeight: 34
                radius: 12
            }
        }

        MultiPointTouchArea {
            anchors.fill: parent
            onTouchUpdated: {
                if (touchPoints[0] !== undefined) {
                    var pos = touchPoints[0].y / sliderVertical1.height * (sliderVertical1.maximumValue - sliderVertical1.minimumValue) + sliderVertical1.minimumValue
                    if (pos > 255)
                        pos = 255
                    if (pos < -255)
                        pos= -255
                    sliderVertical1.value = -1 * Math.round(pos * 100) / 100
                }
            }
            onReleased: {
                sliderVertical1.value = 0
                parent.parent.sendBt(0, sliderVertical2.value)
            }
            onCanceled: {
                console.debug("CANCELED")
            }
        }

    }

    Slider {
        id: sliderVertical2
        minimumValue: -255
        maximumValue: 255
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.1
        anchors.rightMargin: parent.width * 0.1
        width: 200
        onValueChanged: {
            parent.sendBt(sliderVertical1.value, sliderVertical2.value)
        }

        orientation: Qt.Vertical
        style: SliderStyle {
            groove: Rectangle {
                implicitWidth: 200
                implicitHeight: 8
                color: "gray"
                radius: 8
            }
            handle: Rectangle {
                anchors.centerIn: parent
                color: control.pressed ? "white" : "lightgray"
                border.color: "gray"
                border.width: 2
                implicitWidth: 34
                implicitHeight: 34
                radius: 12
            }
        }
        MultiPointTouchArea {
            anchors.fill: parent
            onTouchUpdated: {
                if (touchPoints[0] !== undefined) {
                    var pos = touchPoints[0].y / sliderVertical1.height * (sliderVertical1.maximumValue - sliderVertical1.minimumValue) + sliderVertical1.minimumValue
                    if (pos > 255)
                        pos = 255
                    if (pos < -255)
                        pos= -255
                    sliderVertical2.value = -1 * Math.round(pos * 100) / 100
                }
            }
            onReleased: {
                sliderVertical2.value = 0
                parent.parent.sendBt(sliderVertical1.value, 0)
            }
        }

    }

}
