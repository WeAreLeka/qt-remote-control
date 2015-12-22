import QtQuick 2.0
import QtGraphicalEffects 1.0


Rectangle {
//    border.width: 4
    property int borderWidth
    property string selectedRectangle
    property string imgSource
    property string imgBorderSource
    property int imgRotation
    property color imgColor
    property color trueColor
    property bool hasPicture
    property bool borderVisible: false

    border.width: borderWidth
    border.color: "#808080"
    color: "transparent"
    trueColor: imgColor


    //!\\
    // IF DESKTOP APP (MOUSE USE) SET THIS PROPERTY TO true
    property bool isDesktop: true

    Image {
        source: imgBorderSource
        sourceSize: Qt.size(parent.width, parent.height)
        smooth: true
        visible: borderVisible
        rotation: imgRotation
    }

    Image {
        id: image
        source: imgSource
        sourceSize: Qt.size(parent.width, parent.height)
        smooth: true
        visible: false
    }
    ColorOverlay {
        id: test
        anchors.fill: image
        rotation: imgRotation
        width: parent.width
        source: image
        color: imgColor
    }

    MultiPointTouchArea {
        anchors.fill: parent
        property double begin
        property int i: 0
        onPressed: {
            begin = new Date().valueOf()
            var noStop = true
/*            while (noStop) {
                if (((new Date().valueOf()-begin) / 1000) > longPress) {
                    prevColor = parent.trueColor
                    colorSelector.selected = selectedRectangle
                    colorSelector.visible = true
                    noStop = false
                }
            }*/
        }
        onReleased: {
            if (isDesktop == false || i == 0) {
                var end = new Date().valueOf()
                var ecart = (end - begin) / 1000

                if (ecart < longPress) {
                    if (parent.border.color == "#808080") {
                        parent.border.color = "#000000"
                        parent.borderVisible = true
                    }
                    else if (parent.border.color == "#000000") {
                        parent.border.color = "#808080"
                        parent.borderVisible = false
                    }
                }
                else {
//                    prevColor = parent.trueColor
                    prevColor = (hasPicture == true)?parent.trueColor:parent.color
                    colorSelector.selected = selectedRectangle
                    colorSelector.visible = true
                }
                i++
            }
            else if (isDesktop == false || i == 1) {
                i = 0
            }
        }
    }
}
