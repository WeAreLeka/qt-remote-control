import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtBluetooth 5.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2


Item {
    id: item1
    property double longPress: 0.4
    property color prevColor

    function changeColor(color, selected) {
        if (selected == "topLeft")
            topLeft.color = color
        if (selected == "topRight")
            topRight.color = color
        if (selected == "botLeft")
            botLeft.color = color
        if (selected == "botRight")
            botRight.color = color
        if (selected == "center")
            center.color = color
        if (selected == "right")
            right.color = color
    }

    function getSelected() {
        var array = {};
        array["topLeft"] = topLeft.border.color
        array["topRight"] = topRight.border.color
        array["botLeft"] = botLeft.border.color
        array["botRight"] = botRight.border.color
        array["center"] = center.border.color
        array["right"] = right.border.color
        return array;
    }

    function getColors() {
        var array = {};
        array["topLeft"] = topLeft.color
        array["topRight"] = topRight.color
        array["botLeft"] = botLeft.color
        array["botRight"] = botRight.color
        array["center"] = center.color
        array["right"] = right.color

        return array;
    }

    function closeSelector() {
        colorSelector.visible = false
    }

    // CENTER (EARS)
    LightControlRectangle {
        id: center
        width: parent.width / 3
        height: parent.width / 3
        radius: parent.width / 2
        anchors.top: topRight.bottom
        anchors.topMargin: 0
        anchors.left: parent.left
        color: "purple"
        anchors.leftMargin: parent.width / 3 - 50
        selectedRectangle: "center"
    }

    // RIGHT

    LightControlRectangle {
        id: right
        color: "skyblue"
        anchors.left: topRight.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: botLeft.bottom
        anchors.bottomMargin: 0
        selectedRectangle: "right"
    }

    // TOP LEFT
    LightControlRectangle {
        id: topLeft
        width: parent.width / 2 - 50
        height: parent.width / 2
        color: "red"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        selectedRectangle: "topLeft"
    }

    // TOP RIGHT
    LightControlRectangle {
        id: topRight
        width: parent.width / 2 - 50
        height: parent.width/ 2
        color: "green"
        anchors.left: topLeft.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        selectedRectangle: "topRight"
    }

    // BOT RIGHT
    LightControlRectangle {
        id: botRight
        width: parent.width / 2 - 50
        height: parent.width/ 2
        color: "yellow"
        anchors.left: botLeft.right
        anchors.leftMargin: 0
        anchors.top: center.bottom
        anchors.topMargin: 0
        selectedRectangle: "botRight"
    }

    // BOT LEFT
    LightControlRectangle {
        id: botLeft
        width: parent.width / 2 - 50
        height: parent.width / 2
        color: "blue"
        anchors.top: center.bottom
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        selectedRectangle: "botLeft"
    }
}
