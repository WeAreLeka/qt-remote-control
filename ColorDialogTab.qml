import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import QtBluetooth 5.3
import QtQuick.Controls.Styles 1.4

Item {
    signal colorChanged(var color, var selected)
    property string selected

    Rectangle {
        id: colorWrapper
        width: 300
        height: 400
        color: "lightgray"

        Rectangle {
            color: "#00000000"
            border.color: "#000000"
            anchors.fill: parent
            border.width: 4
            Grid {
                property string selected
                rows: 3; columns: 3; spacing: 0

                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "red"; border.width: 0; MultiPointTouchArea {anchors.fill: parent; onPressed: colorChanged(parent.color, selected);}}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "blue"; MultiPointTouchArea {anchors.fill: parent; onPressed: colorChanged(parent.color, selected)}}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "green"; MultiPointTouchArea {anchors.fill: parent; onPressed: colorChanged(parent.color, selected)}}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "yellow"; MultiPointTouchArea {anchors.fill: parent; onPressed: colorChanged(parent.color, selected)}}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "purple"; MultiPointTouchArea {anchors.fill: parent; onPressed: colorChanged(parent.color, selected)}}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "orange"; MultiPointTouchArea {anchors.fill: parent; onPressed: colorChanged(parent.color, selected)}}

                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "transparent"; MultiPointTouchArea {anchors.fill: parent; onPressed: colorChanged(parent.color, selected)}}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "transparent";Text{text: "Reset"; anchors.horizontalCenter: parent.horizontalCenter; anchors.verticalCenter: parent.verticalCenter} MultiPointTouchArea {anchors.fill: parent; onPressed: colorChanged(parent.color, selected)}}
                Rectangle {width:colorWrapper.width / 3; height: colorWrapper.height / 3;color: "transparent"; MultiPointTouchArea {anchors.fill: parent; onPressed: colorChanged(parent.color, selected)}}
            }
        }
    }
}

