import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2

Item {
    property bool isRecording: false
    property string nameInput: ""
    property string gameInput: ""
    id: dataSave

    Rectangle {
        height: parent.height * 0.8
        width: height
        anchors.top: parent.top
        anchors.topMargin: 10
        border.color: saveButtonOverlay.color
        anchors.horizontalCenter: parent.horizontalCenter
        radius: width/2
        opacity: 0.5
        z: 200

        MultiPointTouchArea {
            anchors.fill: parent
            onPressed: {
                dataSave.forceActiveFocus()
                if (saveButtonOverlay.color == "#ff0000") {
                    saveButtonOverlay.color = "#000000"
                    isRecording = false
                }
                else if (saveButtonOverlay.color == "#000000" && nameFieldText.text != "" && gameFieldText.text != "") {
                    saveButtonOverlay.color = "#ff0000"
                    nameInput =  nameFieldText.text
                    gameInput = gameFieldText.text
                    isRecording = true
                }
                console.debug(nameInput)
                console.debug(gameInput)
            }
        }

        Image {
            id: saveButton
            source: "save_icon.svg"
            sourceSize.width: parent.width * 0.8
            sourceSize.height: parent.width * 0.8
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.width * 0.1
            anchors.leftMargin: parent.width * 0.1
        }

        ColorOverlay {
            id: saveButtonOverlay
            anchors.fill: saveButton
            source: saveButton
            color: "black"
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            dataSave.forceActiveFocus()
        }
    }

    Rectangle {
        id: nameField
        z: 2
        opacity: 1
        focus: false
        width: dataSave.width / 2
        height: dataSave.height
        color: "#BBDFEE"
        TextField {
            id: nameFieldText
            width: parent.width * 0.5
            onFocusChanged: console.log("Focus LEFT changed " + focus)
            onTextChanged: {
                saveButtonOverlay.color = "#000000"
                isRecording = false
            }
            style: TextFieldStyle {
                textColor: "#F39016"
                font.pixelSize: 5* Screen.logicalPixelDensity
                background: Rectangle {
                    radius: 0
                    implicitWidth: dataSave.width / 4
                    implicitHeight: dataSave.height * 0.5
                    border.color: "#333"
                    border.width: 0
                    color: "transparent"
                }
            }

            anchors.centerIn: parent
            horizontalAlignment: TextInput.AlignHCenter
            placeholderText: qsTr("Enter name")
        }
    }
    Rectangle {
        id: gameField
        z:2
        opacity: 1
        focus: false
        width: dataSave.width / 2
        height: dataSave.height
        anchors.left: nameField.right
        color: "#BBDFEE"
        TextField {
            id: gameFieldText
            width: parent.width * 0.5
            onFocusChanged: console.log("Focus RIGHT changed " + focus)
            anchors.centerIn: parent
            onTextChanged: {
                saveButtonOverlay.color = "#000000"
                isRecording = false
            }

            style: TextFieldStyle {
                textColor: "#F39016"
                font.pixelSize: 5 * Screen.logicalPixelDensity
                background: Rectangle {
                    radius: 0
                    implicitWidth: dataSave.width / 4
                    implicitHeight: dataSave.height * 0.5
                    border.color: "#333"
                    border.width: 0
                    color: "transparent"
                }
            }

            horizontalAlignment: TextInput.AlignHCenter
            placeholderText: qsTr("Enter game")
        }
    }
}
