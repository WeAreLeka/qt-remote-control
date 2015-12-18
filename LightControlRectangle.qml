import QtQuick 2.0

Rectangle {
    width: 100
    border.width: 3
    border.color: "#808080"
    property string selectedRectangle


    //!\\
    // IF DESKTOP APP (MOUSE USE) SET THIS PROPERTY TO true
    property bool isDesktop: false

    MultiPointTouchArea {
        anchors.fill: parent
        property double begin
        property int i: 0
        onPressed: {
            begin = new Date().valueOf()
        }
        onReleased: {
            if (isDesktop == false || i == 0) {
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
                    colorSelector.selected = selectedRectangle
                    colorSelector.visible = true
                    console.debug(selectedRectangle)
                    mainPageWraper.selected_main = "Right"
                }
                i++
            }
            else if (isDesktop == false || i == 1) {
                i = 0
            }
        }
    }
}
