import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtBluetooth 5.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2


Item {
    id: item1
    property double longPress: 0.4
    function changeColor(color, selected) {
        console.debug("COUCOU", color, selected)
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
        MultiPointTouchArea {
            anchors.fill: parent
            property double begin

            onPressed: {
                begin = new Date().valueOf()
                var endd
                var stop = true
                while (stop) {
                    endd = new Date().valueOf()
                    if ((endd - begin) / 1000 > longPress) {
                        colorSelectorCenter.visible = true
                        stop = false
                    }
                }

            }
            onReleased: {
                var end = new Date().valueOf()
                var ecart = (end - begin) / 1000
                console.debug("ECART    : "+ ecart+"s")

                if (ecart < longPress) {
                    console.debug("quick click")
                    closeSelector()
                }
                else {
                    console.debug("long click")
                }
            }
        }
    }

    // RIGHT
    Rectangle {
        id: right
        width: 100
        height: parent.height
        color: "skyblue"
        anchors.left: topRight.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        MultiPointTouchArea {

            anchors.fill: parent
            property double begin

            onPressed: {
                begin = new Date().valueOf()
                var endd
                var stop = true
                while (stop) {
                    endd = new Date().valueOf()
                    if ((endd - begin) / 1000 > longPress) {
                        colorSelectorRight.visible = true
                        stop = false
                    }
                }
            }
            onReleased: {
                var end = new Date().valueOf()
                var ecart = (end - begin) / 1000
                console.debug("ECART    : "+ ecart+"s")

                if (ecart < longPress) {
                    console.debug("quick click")
                    closeSelector()
                }
                else {
                    console.debug("long click")
                }
            }
        }
    }

    // TOP LEFT
    Rectangle {
        id: topLeft
        width: parent.width / 2 - 50
        height: parent.width / 2
        color: "red"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        MultiPointTouchArea {
            anchors.fill: parent
            property double begin

            onPressed: {
                begin = new Date().valueOf()
                var endd
                var stop = true
                while (stop) {
                    endd = new Date().valueOf()
                    if ((endd - begin) / 1000 > longPress) {
                        colorSelectorTopLeft.visible = true
                        stop = false
                    }
                }

            }
            onReleased: {
                var end = new Date().valueOf()
                var ecart = (end - begin) / 1000

                if (ecart < longPress) { // SI CLICK COURT
                    closeSelector()
                }
                else {             // SI CLICK LONG
                    console.debug("long click")
                }
            }
        }
    }

    // TOP RIGHT
    Rectangle {
        id: topRight
        width: parent.width / 2 - 50
        height: parent.width/ 2
        color: "green"
        anchors.left: topLeft.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        MultiPointTouchArea {

            anchors.fill: parent
            property double begin

            onPressed: {
                begin = new Date().valueOf()
                var endd
                var stop = true
                while (stop) {
                    endd = new Date().valueOf()
                    if ((endd - begin) / 1000 > longPress) {
                        console.debug("LONG PRESSSSSSSSSs")
                        colorSelectorTopRight.visible = true
                        stop = false
                    }
                }

            }
            onReleased: {
                var end = new Date().valueOf()
                var ecart = (end - begin) / 1000
                console.debug("ECART    : "+ ecart+"s")

                if (ecart < longPress) {
                    console.debug("quick click")
                    closeSelector()
                }
                else {
                    console.debug("long click")
                }
            }
        }
    }



    // BOT RIGHT
    Rectangle {
        id: botRight
        width: parent.width / 2 - 50
        height: parent.width/ 2
        color: "yellow"
        anchors.left: botLeft.right
        anchors.leftMargin: 0
        anchors.top: center.bottom
        anchors.topMargin: 0

        MultiPointTouchArea {
            anchors.fill: parent
            property double begin
            onPressed: {
                begin = new Date().valueOf()
                var endd
                var stop = true
                while (stop) {
                    endd = new Date().valueOf()
                    if ((endd - begin) / 1000 > longPress) {
                        colorSelectorBotRight.visible = true
                        stop = false
                    }
                }

            }
            onReleased: {
                var end = new Date().valueOf()
                var ecart = (end - begin) / 1000
                if (ecart < longPress) {
                    console.debug("quick click")
                    closeSelector()
                }
                else {
                    console.debug("long click")
                }
            }
        }
    }

    // BOT LEFT
    Rectangle {
        id: botLeft
        width: parent.width / 2 - 50
        height: parent.width / 2
        color: "blue"
        anchors.top: center.bottom
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0

        MultiPointTouchArea {
            anchors.fill: parent
            property double begin

            onPressed: {
                begin = new Date().valueOf()
                var endd
                var stop = true
                while (stop) {
                    endd = new Date().valueOf()
                    if ((endd - begin) / 1000 > longPress) {
                        console.debug("LONG PRESSSSSSSSSs")
                        colorSelectorBotLeft.visible = true
                        stop = false
                    }
                }

            }
            onReleased: {
                var end = new Date().valueOf()
                var ecart = (end - begin) / 1000
                console.debug("ECART    : "+ ecart+"s")

                if (ecart < longPress) {
                    console.debug("quick click")
                    closeSelector()
                }
                else {
                    console.debug("long click")
                }
            }
        }
    }
}
