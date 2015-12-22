import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtBluetooth 5.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0

Item {
    id: item1

    property double longPress: 0.3
    property color prevColor

    function changeColor(color, selected) {
        if (selected == "topLeft")
            topLeft.imgColor = color
        else if (selected == "topRight")
            topRight.imgColor = color
        else if (selected == "botLeft")
            botLeft.imgColor = color
        else if (selected == "botRight")
            botRight.imgColor = color
        else if (selected == "center")
            center.color = color
        else if (selected == "right")
            right.color = color
        else if (selected == "leftControl")
            leftControl.color = color
        else if (selected == "rightControl")
            rightControl.color = color
    }

    function getSelected() {
        var array = {};
        array["topLeft"] = (topLeft.border.color == "#000000" ? true : false)
        array["topRight"] = (topRight.border.color == "#000000" ? true : false)
        array["botLeft"] = (botLeft.border.color == "#000000" ? true : false)
        array["botRight"] = (botRight.border.color == "#000000" ? true : false)
        array["center"] = (center.border.color == "#000000" ? true : false)
        array["right"] = (right.border.color == "#000000" ? true : false)
        array["leftControl"] = (leftControl.border.color == "#000000" ? true : false)
        array["rightControl"] = (rightControl.border.color == "#000000" ? true : false)
        return array;
    }

    function getColors() {
        var array = {};
        array["topLeft"] = topLeft.imgColor
        array["topRight"] = topRight.imgColor
        array["botLeft"] = botLeft.imgColor
        array["botRight"] = botRight.imgColor
        array["center"] = center.color
        array["right"] = right.color
        array["leftControl"] = leftControl.color
        array["rightControl"] = rightControl.color

        return array;
    }

    function closeSelector() {
        colorSelector.visible = false
    }

    Item {
        width: parent.width * 0.8
        height: parent.height * 0.8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.2
        Image {
            id: lekaPicture
            source: "leka_top.png"
            sourceSize: Qt.size(parent.width, parent.height)
            smooth: true
            visible: true
            rotation: 180
        }
/*        Rectangle {
            anchors.fill: parent
            color: "black"
            opacity: 0.2
        }*/

//        anchors.bottomMargin: parent.height * 0.1
        // TOP LEFT
        LightControlRectangle {
            id: topLeft
            width: parent.width / 2 - parent.width * 0.025
            height: width
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            imgSource: "quarters_cut_right.png"
            imgBorderSource: "quarters_cut_right_border.png"
            imgColor: "red"
            imgRotation: 180
            selectedRectangle: "topLeft"
            borderWidth: 0
            hasPicture: true

            opacity: 0.4
        }

        // TOP RIGHT
        LightControlRectangle {
            id: topRight
            width: parent.width / 2 - parent.width * 0.025
            height: width
            anchors.left: topLeft.right
            anchors.leftMargin: parent.width * 0.025
            anchors.top: parent.top
            anchors.topMargin: 0
            imgSource: "quarters_cut_left.png"
            imgBorderSource: "quarters_cut_left_border.png"
            imgRotation: 180
            imgColor: "blue"
            selectedRectangle: "topRight"
            borderWidth: 0
            hasPicture: true

            opacity: 0.4
        }


        // BOT LEFT
        LightControlRectangle {
            id: botLeft
            width: parent.width / 2 - parent.width * 0.025
            height: width
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: topLeft.bottom
            anchors.topMargin: parent.width * 0.025
            imgSource: "quarters.png"
            imgBorderSource: "quarters_border.png"
            imgRotation: 180
            imgColor: "green"
            selectedRectangle: "botLeft"
            borderWidth: 0
            hasPicture: true

            opacity: 0.4
        }

        // BOT RIGHT
        LightControlRectangle {
            id: botRight
            width: parent.width / 2 - parent.width * 0.025
            height: width
            anchors.left: botLeft.right
            anchors.leftMargin: parent.width * 0.025
            anchors.top: topRight.bottom
            anchors.topMargin: parent.width * 0.025
            imgSource: "quarters.png"
            imgBorderSource: "quarters_border.png"
            imgRotation: 90
            imgColor: "yellow"
            selectedRectangle: "botRight"
            borderWidth: 0
            hasPicture: true

            opacity: 0.4
        }

        // CENTER (EARS)
        LightControlRectangle {
            id: center
            width: parent.width / 3.5
            height: parent.width / 3.5
            radius: parent.width / 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "purple"
            imgColor: "purple"
            selectedRectangle: "center"
            borderWidth: 4
            hasPicture: false

            opacity: 0.4
        }

    }

    // LEFT CONTROL
    LightControlRectangle {
        id: leftControl
        width: parent.width / 2 - parent.height * 0.1
        height: parent.height * 0.2
        anchors.bottom: parent.bottom
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        imgColor: "green"
        color: "green"
        selectedRectangle: "leftControl"
        borderWidth: 4
        hasPicture: false
    }

    // RIGHT CONTROL
    LightControlRectangle {
        id: rightControl
        width: parent.width / 2 - parent.height * 0.1
        height: parent.height * 0.2
        anchors.bottom: parent.bottom
        anchors.left: leftControl.right
        anchors.leftMargin: 0
        imgColor: "green"
        color: "green"
        selectedRectangle: "rightControl"
        borderWidth: 4
        hasPicture: false
    }

    // RIGHT
    LightControlRectangle {
        id: right
        width: parent.height * 0.2
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        color: "skyblue"
        imgColor: "skyblue"
        selectedRectangle: "right"
        borderWidth: 4
        hasPicture: false
    }
}
