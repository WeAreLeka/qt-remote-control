import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import QtBluetooth 5.3
import QtQuick.Controls.Styles 1.4

Item {
    id: colorMain
    anchors.fill: parent
    signal colorChanged(var color, var selected)
    property string selected
    property int rowsNumber: 4 // (3 rows for colors + 1 for submit)

    // ADD NEW RECTANGLE TO ADD COLORS :D
    function get_selected_color() {
        for (var i=0; grid.children[i] != undefined; i++) {
            if (grid.children[i].border.width == 3) {
                return grid.children[i].color
            }
        }
    }
    Rectangle {
        width: parent.width
        height: parent.height
        color: "grey"
        MouseArea {
            anchors.fill: parent
            onClicked: {

            }
        }

        Rectangle {
            id: colorWrapper
            width: parent.width * 0.8
            height: parent.height * 0.8
            anchors.centerIn: parent
            color: "lightgray"

            Rectangle {
                id: underline
                height: 5 //styleData.selected ? 5:0
                width: parent.width / 2
                anchors.top: parent.top
                x: 0
                anchors.topMargin: 45
                color: "#F39016"
                z:500
            }
            PropertyAnimation { id: tab1; target: underline; property: "x"; to: 0; duration: 400 }
            PropertyAnimation { id: tab2; target: underline; property: "x"; to: underline.width; duration: 400 }


            Rectangle {
                id: rectX
                color: "#00000000"
                border.color: "#000000"
                anchors.fill: parent
                border.width: 0
                TabView {
                    id: tabview
                    onCurrentIndexChanged:{
                        console.debug("TAB CHANGED : " )
                        console.debug("SIMPLE : " + simple.visible)
                        console.debug("WHEEL " + wheel.visible)
                        if (simple.visible) {
                            tab1.start()
                        }
                        else if (wheel.visible) {
                            tab2.start()
                        }
                    }
                    anchors.fill: parent
                    style: TabViewStyle {
                        frameOverlap: 1
                        tab: Rectangle {
                            id: styleTab
                            implicitWidth: rectX.width / 2
                            color: "#55AFD7"
                            border.color:  "#55AFD7"
                            implicitHeight: 50
                            Text {
                                id: text
                                anchors.centerIn: parent
                                //                            font.bold: true
                                font.pixelSize: 20
                                font.family: customFont.name
                                text: styleData.title
                                color: styleData.selected ? "white" : "#B1EAF1"
                            }
                        }

                        frame: Rectangle {
                            color: "transparent"
                        }
                    }

                    Tab {
                        title: "SIMPLE"
                        anchors.fill: parent
                        id: simple

                        Item {
                            id: itemtab
                            Rectangle {
                                width: simple.width
                                height: 20 * Screen.logicalPixelDensity
                                color: "#55AFD7"
                                anchors.bottom: itemtab.bottom
                                Text{
                                    text: "VALIDER";
                                    font.family: customFont.name
                                    anchors.centerIn: parent
                                    anchors.bottom: parent.bottom
                                }
                                MultiPointTouchArea {
                                    anchors.fill: parent;
                                    onPressed:{
                                        lightController.closeSelector();
                                        colorChanged(colorMain.get_selected_color(), selected);
                                    }
                                    onReleased:{
                                        lightController.closeSelector();
                                        colorChanged(colorMain.get_selected_color(), selected);
                                    }
                                }
                            }
                            Grid {
                                width: parent.width;
                                anchors.horizontalCenter: parent.horizontalCenter
                                id: grid
                                rows: rowsNumber; columns: 3; spacing: 0
                                function remove_border() {
                                    var i
                                    for (i=0; grid.children[i] != undefined; i++)
                                        grid.children[i].border.width = 0
                                }

                                // add colors by adding a rectangle item, just change the color parameter and adapt the column and the height of the parent element
                                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "red"; border.width: 0; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); grid.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "blue"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); grid.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "green"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); grid.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "yellow"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); grid.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "purple"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); grid.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "#AFCD37"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); grid.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "#EB1C6A"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); grid.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "#EF8F21"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); grid.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "#56AED4"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); grid.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                            }
                        }


                    }
                    Tab {
                        title: "WHEEL"
                        id: wheel
                        ColorWheel {
                            id: colorwheel
                            anchors.centerIn: parent
                            customHeight: rectX.width
                            customWidth: customHeight
                            onCustomColorChanged: {
                                if (color != "#ffffff") {
                                    selected_main=selected;
                                    lightController.changeColor(color, selected)
                                }
                            }

                            Rectangle {
                                id: validate
                                anchors.fill: parent
                                color: "transparent"

                                Rectangle {
                                    width: validate.width
                                    height: 20 * Screen.logicalPixelDensity
                                    color: "#55AFD7"
                                    anchors.bottom: validate.bottom
                                    Text{
                                        text: "VALIDER";
                                        font.family: customFont.name
                                        anchors.centerIn: parent
                                        anchors.bottom: parent.bottom
                                    }
                                    MultiPointTouchArea {
                                        anchors.fill: parent;
                                        onPressed:{
                                            lightController.closeSelector();
                                            colorChanged(colorMain.get_selected_color(), selected);
                                        }
                                        onReleased:{
                                            lightController.closeSelector();
                                            colorChanged(colorMain.get_selected_color(), selected);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
