import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import QtBluetooth 5.3
import QtQuick.Controls.Styles 1.4

Item {
    id: colorMain
    signal colorChanged(var color, var selected)
    property string selected
    function remove_border() {
        var i = 0
        rect1.border.width = 0;
        rect2.border.width = 0;
        rect3.border.width = 0;
        rect4.border.width = 0;
        rect5.border.width = 0;
        rect6.border.width = 0;
    }

    function get_selected_color() {
        var array=[rect1, rect2, rect3, rect4, rect5, rect6]
        for (var i=0; i<array.length; i++) {
            if (array[i].border.width == 3) {
                return array[i].color
            }
        }
    }

    Rectangle {
        id: colorWrapper
        width: 300
        height: 400
        color: "lightgray"

        Rectangle {
            id: rectX
            color: "#00000000"
            border.color: "#000000"
            anchors.fill: parent
            border.width: 4
            Grid {
                id: grid
                property string selected
                rows: 3; columns: 3; spacing: 0

                Rectangle {id: rect1;width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "red"; border.width: 0; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); colorMain.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                Rectangle {id: rect2;width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "blue"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); colorMain.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                Rectangle {id: rect3;width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "green"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); colorMain.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                Rectangle {id: rect4;width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "yellow"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); colorMain.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                Rectangle {id: rect5;width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "purple"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); colorMain.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}
                Rectangle {id: rect6;width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "orange"; MultiPointTouchArea {anchors.fill: parent; onPressed:{ colorChanged(parent.color, selected); colorMain.remove_border(); parent.border.width = 3; parent.border.color = "black"} }}

                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "transparent"; MouseArea {anchors.fill: parent; onPressed:{lightController.closeSelector(); colorChanged(colorMain.get_selected_color(), selected);}}}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "transparent";Text{text: "VALIDER"; anchors.horizontalCenter: parent.horizontalCenter; anchors.verticalCenter: parent.verticalCenter} MouseArea {anchors.fill: parent; onPressed:{lightController.closeSelector(); colorChanged(colorMain.get_selected_color(), selected)}}}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "transparent"; MouseArea {anchors.fill: parent;  onPressed:{lightController.closeSelector(); colorChanged(colorMain.get_selected_color(), selected);}}}
            }
        }
    }
}

