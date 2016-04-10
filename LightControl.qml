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

    // change lightcontrol color depending to the selected element
    function changeColor(color, selected) {  // .COLOR WHEN NO IMG .IMGCOLOR WHEN IMG
        console.debug("color: " + color + " |  selected : "+ selected)
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
            right.imgColor = color
        else if (selected == "leftControl")
            leftControl.imgColor = color
        //        leftControl.color = color

        else if (selected == "rightControl")
            rightControl.imgColor = color
        //            rightControl.color = color
    }

    // return the an array of the selected lightcontrol elements
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

    // return the colors of all the lightcontrol elements
    function getColors() {
        var array = {};
        array["topLeft"] = topLeft.imgColor
        array["topRight"] = topRight.imgColor
        array["botLeft"] = botLeft.imgColor
        array["botRight"] = botRight.imgColor
        array["center"] = center.color
        array["right"] = right.imgColor
        array["leftControl"] = leftControl.imgColor
        array["rightControl"] = rightControl.imgColor
        //        array["leftControl"] = leftControl.color
        //        array["rightControl"] = rightControl.color

        return array;
    }

    // close the colorPicker
    function closeSelector() {
        colorSelector.visible = false
    }

    // structure of the LightControl (bottom right of the app)

    // RIGHT
    LightControlRectangle {
        id: right
        width: parent.width * 0.45
        anchors.right: item1.right
        anchors.top: item1.top
        anchors.topMargin: 0
        anchors.bottom: item1.bottom
        anchors.bottomMargin: 0
        selectedRectangle: "right"
        imgSource: "pictures/right.png"
        imgBorderSource: "pictures/right_border.png"
        imgRotation: 0
        imgColor: "green"
        borderWidth: 0
        hasPicture: true
        opacity: 0.4
    }

    // LEFT CONTROL
    LightControlRectangle {
        id: leftControl
        width: parent.width / 2.6 - parent.width * 0.0125
        height: parent.height * 0.4
        anchors.bottom: parent.bottom
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        imgColor: "#EF8F21"
        selectedRectangle: "leftControl"
        imgSource: "pictures/bottom_left.png"
        imgBorderSource: "pictures/bottom_left_border.png"
        imgRotation: 0
        borderWidth: 0
        opacity: 0.4
        hasPicture: true
    }


    // RIGHT CONTROL
    LightControlRectangle {
        id: rightControl
        width: parent.width / 2.6 - parent.width * 0.025
        height: parent.height * 0.4
        anchors.bottom: parent.bottom
        anchors.left: leftControl.right
        anchors.leftMargin: parent.width * 0.0375
        imgColor: "#EB1C6A"
        selectedRectangle: "rightControl"
        imgSource: "pictures/bottom_right.png"
        imgBorderSource: "pictures/bottom_right_border.png"
        borderWidth: 0
        opacity: 0.4
        hasPicture: false
    }

    Item {
        width: parent.width * 0.8
        height: parent.height * 0.8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.2
        Image {
            id: lekaPicture
            //            source: "pictures/leka_top.png"
            sourceSize: Qt.size(parent.width, parent.height)
            smooth: true
            visible: true
            rotation: 180
        }

        // TOP LEFT
        LightControlRectangle {
            id: topLeft
            width: parent.width / 2 - parent.width * 0.025
            height: width
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            imgSource: "pictures/quarters.png"
            imgBorderSource: "pictures/quarters_border.png"
            imgColor: "#EB8F1D"
            imgRotation: -90
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
            imgSource: "pictures/quarters.png"
            imgBorderSource: "pictures/quarters_border.png"
            imgRotation: 0
            imgColor: "#AFCD37"
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
            imgSource: "pictures/quarters.png"
            imgBorderSource: "pictures/quarters_border.png"
            imgRotation: 180
            imgColor: "#EB1C6A"
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
            imgSource: "pictures/quarters.png"
            imgBorderSource: "pictures/quarters_border.png"
            imgRotation: 90
            imgColor: "#56AED4"
            selectedRectangle: "botRight"
            borderWidth: 0
            hasPicture: true

            opacity: 0.4
        }

        // CENTER (EARS)
        LightControlRectangle {
            id: center
            width: parent.width / 4
            height: width
            radius: parent.width / 2
            anchors.top: parent.top
            anchors.topMargin: parent.height / 2 - height / 2
            anchors.left: topLeft.right
            anchors.leftMargin: -1 * (parent.width / 8 - parent.width * 0.015) - 1
            selectedRectangle: "center"
            borderWidth: 5
            imgColor: "white"
            hasPicture: true
            opacity: 0.4
        }
    }
}
