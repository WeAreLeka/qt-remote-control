import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4


Slider {
    signal sendBt(int leftMotor, int rightMotor)
    onSendBt: {
        // add 0 and sign before int (beaucause of the arduino code)
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

        function set_value(val) {
            val = Math.round(val * 100) / 100
            if (val < 100 && val >= 10)
                val = "0"+val
            else if (val > -100 && val <= -10)
                val = "0"+Math.abs(val)
            else if (val === 0)
                val = "000"
            else if (val < 10 && val > 0)
                val = "00"+val
            else if (val > -10 && val < 0)
                val = "00"+Math.abs(val)
            else if (val >= 100)
                val = val
            else if (val <= -100)
                val = val
            return val
        }

        var l_r_r = Math.round(main_left_color.color.r * 255)
        var l_r_g = Math.round(main_left_color.color.g * 255)
        var l_r_b = Math.round(main_left_color.color.b * 255)

        var l_l_r = Math.round(main_right_color.color.r * 255)
        var l_l_g = Math.round(main_right_color.color.g * 255)
        var l_l_b = Math.round(main_right_color.color.b * 255)

        socket.sendStringData("["+leftMotor+","+rightMotor+","+set_value(l_l_r)+","+set_value(l_l_b)+","+set_value(l_l_g)+","+set_value(l_r_r)+","+set_value(l_r_b)+","+set_value(l_r_g)+"]")
        console.debug("["+leftMotor+","+rightMotor+","+set_value(l_l_r)+","+set_value(l_l_g)+","+set_value(l_l_b)+","+set_value(l_r_r)+","+set_value(l_r_g)+","+set_value(l_r_b)+"]")
    }

    id: sliderVertical1
    width: 80
    anchors.rightMargin: 0
    anchors.bottom: parent.bottom
    anchors.top: parent.top
    minimumValue: -255
    maximumValue: 255

    onUpdateValueWhileDraggingChanged: {
        console.debug("onPressedChanged")
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

    // adding MultiPointTouchArea for handeling multitouch interaction
    MultiPointTouchArea {
        anchors.fill: parent

        // EVERY 100 ms SEND REQUEST TO sendBt
        function launch() {
            sendBt(sliderVertical1.value, sliderVertical2.value)
            console.debug("L : "+sliderVertical1.value + " R : "+sliderVertical2.value)
        }

        Timer {
            interval: 100
            running: true
            repeat: true
            onTriggered: parent.launch()
        }

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

        // When slider slider is released, set value to 0 and call sendBt to update informations
        onReleased: {
            sliderVertical1.value = 0
        }
    }
}
