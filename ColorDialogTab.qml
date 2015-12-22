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
    function remove_border() {
        var i
        for (i=0; grid.children[i] != undefined; i++)
            grid.children[i].border.width = 0
    }

    // ADD NEW RECTANGLE TO ADD COLORS :D
    function get_selected_color() {
        for (var i=0; grid.children[i] != undefined; i++) {
            if (grid.children[i].border.width == 3) {
                return grid.children[i].color
            }
        }
    }

    Rectangle {
        id: colorWrapper
        width: parent.width
        height: parent.height
        color: "lightgray"

        Rectangle {
            id: rectX
            color: "#00000000"
            border.color: "#000000"
            anchors.fill: parent
            border.width: 2
            Grid {
                id: grid
                property string selected
                rows: rowsNumber; columns: 3; spacing: 0

                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "red"; border.width: 0; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); colorMain.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "blue"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); colorMain.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "green"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); colorMain.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "yellow"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); colorMain.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "purple"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); colorMain.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "orange"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); colorMain.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "skyblue"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); colorMain.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "pink"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); colorMain.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / rowsNumber;color: "magenta"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); colorMain.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}

                //  onPressed + onReleased bcs sometimes onPressed not detected :/
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "transparent"; MultiPointTouchArea {anchors.fill: parent; onPressed:{lightController.closeSelector(); colorChanged(colorMain.get_selected_color(), selected);} onReleased:{lightController.closeSelector(); colorChanged(colorMain.get_selected_color(), selected);}}}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "transparent";Text{text: "VALIDER"; anchors.horizontalCenter: parent.horizontalCenter; anchors.verticalCenter: parent.verticalCenter} MultiPointTouchArea {anchors.fill: parent; onPressed:{lightController.closeSelector(); colorChanged(colorMain.get_selected_color(), selected)} onReleased:{lightController.closeSelector(); colorChanged(colorMain.get_selected_color(), selected)}}}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "transparent"; MultiPointTouchArea {anchors.fill: parent;  onPressed:{lightController.closeSelector(); colorChanged(colorMain.get_selected_color(), selected);} onReleased:{lightController.closeSelector(); colorChanged(colorMain.get_selected_color(), selected);}}}
            }
        }
    }
}

