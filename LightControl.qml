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
        array["topLeft"] = topLeft
        array["topRight"] = topRight.color
        array["botLeft"] = botLeft.color
        array["botRight"] = botRight.color
        array["center"] = center.color
        array["right"] = right.color

        return array;
    }

    function closeSelector() {
        colorSelectorTopLeft.visible = false
        colorSelectorTopRight.visible = false
        colorSelectorBotLeft.visible = false
        colorSelectorBotRight.visible = false
        colorSelectorCenter.visible = false
        colorSelectorRight.visible = false
    }

    // CENTER (EARS)
    Rectangle {
        id: center
        width: parent.width / 3
        height: parent.width / 3
        radius: parent.width / 2
        anchors.top: topRight.bottom
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: parent.width / 3 - 50
        color: "purple"
        border.width: 3
        border.color: "#808080"

        MultiPointTouchArea {
            anchors.fill: parent
            property double begin
            property int i: 0

            onPressed: {
                begin = new Date().valueOf()
            }
            onReleased: {
//                if (i == 0) {
                    console.debug("released")
                    var end = new Date().valueOf()
                    var ecart = (end - begin) / 1000

                    if (ecart < longPress) {
                        console.debug("quick click")
                        if (parent.border.color == "#808080")
                            parent.border.color = "#000000"
                        else if (parent.border.color == "#000000")
                            parent.border.color = "#808080"
                    }
                    else {
                        console.debug("long click")
                        prevColor = parent.color
                        colorSelectorCenter.visible = true
                        mainPageWraper.selected_main = "Center"
                    }
                    i++
/*                }
                else if (i == 1) {
                    i = 0
                }*/
            }
        }
    }

    // RIGHT
    Rectangle {
        id: right
        width: 100
        color: "skyblue"
        border.width: 3
        border.color: "#808080"
        anchors.left: topRight.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: botLeft.bottom
        anchors.bottomMargin: 0

        MultiPointTouchArea {
            anchors.fill: parent
            property double begin
            property int i: 0
            onPressed: {
                begin = new Date().valueOf()
            }
            onReleased: {
//                if (i == 0) {
                    console.debug("released")
                    var end = new Date().valueOf()
                    var ecart = (end - begin) / 1000

                    if (ecart < longPress) {
                        console.debug("quick click")
                        if (parent.border.color == "#808080")
                            parent.border.color = "#000000"
                        else if (parent.border.color == "#000000")
                            parent.border.color = "#808080"
                    }
                    else {
                        console.debug("long click")
                        prevColor = parent.color
                        colorSelectorRight.visible = true
                        mainPageWraper.selected_main = "Right"
                    }
                    i++
/*                }
                else if (i == 1) {
                    i = 0
                }*/
            }
        }
    }


    // TOP LEFT
    Rectangle {
        id: topLeft
        width: parent.width / 2 - 50
        height: parent.width / 2
        color: "red"
        border.width: 3
        border.color: "#808080"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        MultiPointTouchArea {
            anchors.fill: parent
            property double begin
            property int i: 0

            onPressed: {
                begin = new Date().valueOf()
            }
            onReleased: {
//                if (i == 0) {
                    console.debug("released")
                    var end = new Date().valueOf()
                    var ecart = (end - begin) / 1000

                    if (ecart < longPress) {
                        console.debug("quick click")
                        if (parent.border.color == "#808080")
                            parent.border.color = "#000000"
                        else if (parent.border.color == "#000000")
                            parent.border.color = "#808080"
                    }
                    else {
                        console.debug("long click")
                        prevColor = parent.color
                        colorSelectorTopLeft.visible = true
                        mainPageWraper.selected_main = "topLeft"
                    }
                    i++
/*                }
                else if (i == 1) {
                    i = 0
                }*/
            }
        }
    }

    // TOP RIGHT
    Rectangle {
        id: topRight
        width: parent.width / 2 - 50
        height: parent.width/ 2
        color: "green"
        border.width: 3
        border.color: "#808080"
        anchors.left: topLeft.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        MultiPointTouchArea {

            anchors.fill: parent
            property double begin
            property int i: 0

            onPressed: {
                begin = new Date().valueOf()
            }
            onReleased: {
//                if (i == 0) {
                    console.debug("released")
                    var end = new Date().valueOf()
                    var ecart = (end - begin) / 1000

                    if (ecart < longPress) {
                        console.debug("quick click")
                        if (parent.border.color == "#808080")
                            parent.border.color = "#000000"
                        else if (parent.border.color == "#000000")
                            parent.border.color = "#808080"
                    }
                    else {
                        console.debug("long click")
                        prevColor = parent.color
                        colorSelectorTopRight.visible = true
                        mainPageWraper.selected_main = "topRight"
                    }
                    i++
/*                }
                else if (i == 1) {
                    i = 0
                }*/
            }
        }
    }



    // BOT RIGHT
    Rectangle {
        id: botRight
        width: parent.width / 2 - 50
        height: parent.width/ 2
        color: "yellow"
        border.width: 3
        border.color: "#808080"
        anchors.left: botLeft.right
        anchors.leftMargin: 0
        anchors.top: center.bottom
        anchors.topMargin: 0

        MultiPointTouchArea {
            anchors.fill: parent
            property double begin
            property int i: 0
            onPressed: {
                begin = new Date().valueOf()
            }
            onReleased: {
//                if (i == 0) {
                    console.debug("released")
                    var end = new Date().valueOf()
                    var ecart = (end - begin) / 1000

                    if (ecart < longPress) {
                        console.debug("quick click")
                        if (parent.border.color == "#808080")
                            parent.border.color = "#000000"
                        else if (parent.border.color == "#000000")
                            parent.border.color = "#808080"
                    }
                    else {
                        console.debug("long click")
                        prevColor = parent.color
                        colorSelectorBotRight.visible = true
                        mainPageWraper.selected_main = "botRight"
                    }
                    i++
/*                }
                else if (i == 1) {
                    i = 0
                }*/
            }
        }
    }

    // BOT LEFT
    Rectangle {
        id: botLeft
        width: parent.width / 2 - 50
        height: parent.width / 2
        color: "blue"
        border.width: 3
        border.color: "#808080"
        anchors.top: center.bottom
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0


        MultiPointTouchArea {
            anchors.fill: parent
            property double begin
            property int i: 0

            onPressed: {
                begin = new Date().valueOf()
            }

            onReleased: {
//                if (i == 0) {
                    console.debug("released")
                    var end = new Date().valueOf()
                    var ecart = (end - begin) / 1000

                    if (ecart < longPress) {
                        console.debug("quick click")
                        if (parent.border.color == "#808080")
                            parent.border.color = "#000000"
                        else if (parent.border.color == "#000000")
                            parent.border.color = "#808080"
                    }
                    else {
                        console.debug("long click")
                        prevColor = parent.color
                        colorSelectorBotLeft.visible = true
                        mainPageWraper.selected_main = "botLeft"
                    }
                    i++
/*                }
                else if (i == 1) {
                    i = 0
                }*/
            }
        }
    }
}
