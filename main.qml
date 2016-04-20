import QtQuick 2.4
import QtQuick.Window 2.2
import QtBluetooth 5.3
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import QtQml 2.0
import QtGraphicalEffects 1.0
import QtSensors 5.3 as Sensors

//import Qt.labs.gestures 1.0

// adding localstorage :)
import "Database.js" as Db

Item {
    id: mainPageWraper
    visible: true
    property string selected_main

    // GLOBAL ANGLE UPDATED WHEN DATA RECEIVED FROM ARDUINO
    property real psi: 0
    property real theta: 0
    property real phi: 0



    // import font
    FontLoader { id: customFont; source: "Typ1451.otf" }

    // save state on close
    Component.onDestruction: {
        Db.init()
        var savedColors = Db.getRecords()
        Db.updateRecord(lightController.getColors().topLeft, "topLeft")
        Db.updateRecord(lightController.getColors().topRight, "topRight")
        Db.updateRecord(lightController.getColors().botLeft, "botLeft")
        Db.updateRecord(lightController.getColors().botRight, "botRight")
        Db.updateRecord(lightController.getColors().center, "center")
        Db.updateRecord(lightController.getColors().right, "right")
        Db.updateRecord(lightController.getColors().leftControl, "leftControl")
        Db.updateRecord(lightController.getColors().rightControl, "rightControl")
        console.log("QML exit")

    }

    // outside click event when color popup open
//    MouseArea {
//        anchors.fill: parent
//        onClicked: {

//            //FileIO.save("/home/erwan/Desktop/test42.txt", "nouvelle donnee");
//            function is_open(){
//                if (colorSelector.visible == true)
//                    return true
//                return false
//            }

//            if (is_open() == true) {
//                lightController.changeColor(lightController.prevColor, selected_main)
//                lightController.closeSelector()
//            }
//        }
//    }


    /*GestureArea {
        anchors.fill: parent
        onGesture: {
            console.debug("swipe")
        }
    }*/
    RecordData {
        id: recordData
        visible: stackView.currentItem == scanner?false:true
        width: parent.width * 0.5
        anchors.horizontalCenter: parent.horizontalCenter
        height: 25 * Screen.logicalPixelDensity
        z: 500
    }

    // background of the main page
    Rectangle {
        id: backgroudRectangle
        anchors.fill: parent
        color: stackView.currentItem == scanner?"#eaeaea":"white"
        Image {
            height: parent.height * 0.6
            width: parent.height * 0.6
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0.2
            id: background
            visible: stackView.currentItem == scanner?false:true
            source: "pictures/logo.png"
        }
    }

    // load previous colors from db
    Item {
        id:databaseLoader
        Component.onCompleted: {
            Db.init()
            var savedColors = Db.getRecords()
            lightController.changeColor(savedColors[0].content, "topLeft")
            lightController.changeColor(savedColors[1].content, "topRight")
            lightController.changeColor(savedColors[2].content, "botLeft")
            lightController.changeColor(savedColors[3].content, "botRight")
            lightController.changeColor(savedColors[4].content, "center")
            lightController.changeColor(savedColors[5].content, "right")
            lightController.changeColor(savedColors[6].content, "leftControl")
            lightController.changeColor(savedColors[7].content, "rightControl")
        }
    }

    // FIRST VIEW WRAPPER (main view, not bluetooth)
    Item {
        id: mainView
        width: parent.width
        height: parent.height
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right


        //Top right button to launch the applications
//        Button{
//            id: gameButtonRainbow
//            text: "rainbow"
//            anchors.top: parent.verticalCenter
//            anchors.left: parent.horizontalCenter
//            onClicked:{
//                if(socket.connected == true){
//                    socket.sendStringData("<R>")
//                    console.debug("<R>")
//                    }

//                }
//        }





        GamePage{
            id:gamepage
//            onBack: {
//                stackView.pop()
//            }
            anchors.top : parent.top
            anchors.topMargin: 300
            //anchors.verticalCenter : parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter


        }

//        ImgButton{
//            id: gamePageButton
//            width: height * 0.7
//            height: 15 * Screen.logicalPixelDensity
//            anchors.left: parent.left
//            anchors.leftMargin: parent.width * 0.01
//            anchors.top: parent.top
//            anchors.topMargin: parent.width * 0.01

//            imgSrc: "pictures/gamePage.svg"

//            onClicked: {  // OPEN Game Page
//                stackView.push({item:gamepage, immediate: true, replace: true})
//            }
//        }

        // JOYSTICK ELEMENT (JoyStick.qml)
        JoyStick {
            id:joystick

            property string oldDir
            property int oldPower

            width: parent.height * 0.5
            height: parent.height * 0.5
            anchors.left: parent.left
            anchors.leftMargin: 50
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50

            function set_value(val) {
                val = Math.round(val * 100) / 100
                if (val < 100 && val >= 10)
                    val = "+0"+val
                else if (val > -100 && val <= -10)
                    val = "-0"+Math.abs(val)
                else if (val === 0)
                    val = "+000"
                else if (val < 10 && val > 0)
                    val = "+00"+val
                else if (val > -10 && val < 0)
                    val = "-00"+Math.abs(val)
                else if (val >= 100)
                    val = "+"+val
                else if (val <= -100)
                    val = val
                return val
            }

            function set_value_led(val) {
                val = Math.round(val * 100) / 100
                if (val < 100 && val >= 10)
                    val = "0"+val
                else if (val > -100 && val <= -10)
                    val = "0"+Math.abs(val)
                else if (val === 0)
                    val = "000"
                else if (val < 10 && val > 0)
                    val = "00"+val
                else if (val > -10 && val < 0)
                    val = "00"+Math.abs(val)
                else if (val >= 100)
                    val = val
                else if (val <= -100)
                    val = val
                return val
            }
            function setMotorFromStab(output) {
                console.debug(output);
                var array = {};
                if (output[1] == 0) {
                    array["left"] = set_value(output[0]);
                    array["right"] = set_value(-1 * output[0]);
                }
                else if (output[1] == 1) {
                    array["left"] = set_value(-1 * output[0]);
                    array["right"] = set_value(output[0]);
                }
                else if (output[1] == 2) {
                    array["left"] = set_value(output[0]);
                    array["right"] = set_value(output[0]);
                }
                else if (output[1] == 3) {
                    array["left"] = set_value(-1 * output[0]);
                    array["right"] = set_value(-1 * output[0]);
                }
                return array;
            }

            function rgbToBin(r,g,b){
                var bin = r << 16 | g << 8 | b;
                return (function(h){
                    return new Array(25-h.length).join("0")+h
                })(bin.toString(2))
            }

            function rgbToUint32(color) {
                var red = Math.round(color.r * 255)
                var green = Math.round(color.g * 255)
                var blue = Math.round(color.b * 255)
                var uint32 = rgbToBin(red,green,blue)
                return uint32
            }

            onDirChanged: {
                if (socket.connected == true) {
                    //if (true) {
                    var colorArray = lightController.getColors()
                    var colorEars = colorArray.center
                    var colorTopLeft = colorArray.topLeft
                    var colorTopRight = colorArray.topRight
                    var colorBotLeft = colorArray.botLeft
                    var colorBotRight = colorArray.botRight
                    var ct
                    var fl
                    var fr
                    var bl
                    var br
                    var mainControl = colorArray.right
                    var rightControl = colorArray.rightControl
                    var leftControl = colorArray.leftControl

                    // MAIN CONTROLL
                    if (lightController.getSelected().right == true)
                        mainControl = set_value_led(Math.round(mainControl.r * 255))+","+set_value_led(Math.round(mainControl.g * 255))+","+set_value_led(Math.round(mainControl.b * 255))
                    else if (lightController.getSelected().right == false)
                        mainControl = "000,000,000"

                    // RIGHT CONTROLL
                    if (lightController.getSelected().rightControl == true)
                        rightControl = set_value_led(Math.round(rightControl.r * 255))+","+set_value_led(Math.round(rightControl.g * 255))+","+set_value_led(Math.round(rightControl.b * 255))
                    else if (lightController.getSelected().rightControl == false)
                        rightControl = null

                    // LEFT CONTROLL
                    if (lightController.getSelected().leftControl == true)
                        leftControl = set_value_led(Math.round(leftControl.r * 255))+","+set_value_led(Math.round(leftControl.g * 255))+","+set_value_led(Math.round(leftControl.b * 255))
                    else if (lightController.getSelected().leftControl == false)
                        leftControl = null


                    if (lightController.getSelected().center == true)
                        ct = set_value_led(Math.round(colorEars.r * 255))+","+set_value_led(Math.round(colorEars.g * 255))+","+set_value_led(Math.round(colorEars.b * 255))
                    else if(lightController.getSelected().center == false)
                        ct = mainControl

                    if (lightController.getSelected().topLeft == true)
                        fl = set_value_led(Math.round(colorTopLeft.r * 255))+","+set_value_led(Math.round(colorTopLeft.g * 255))+","+set_value_led(Math.round(colorTopLeft.b * 255))
                    else if(lightController.getSelected().topLeft == false) {
                        if (leftControl != null)
                            fl = leftControl
                        else
                            fl = mainControl
                    }

                    if (lightController.getSelected().topRight == true)
                        fr = set_value_led(Math.round(colorTopRight.r * 255))+","+set_value_led(Math.round(colorTopRight.g * 255))+","+set_value_led(Math.round(colorTopRight.b * 255))
                    else if(lightController.getSelected().topRight == false) {
                        if (rightControl != null)
                            fr = rightControl
                        else
                            fr = mainControl
                    }

                    if (lightController.getSelected().botLeft == true)
                        bl = set_value_led(Math.round(colorBotLeft.r * 255))+","+set_value_led(Math.round(colorBotLeft.g * 255))+","+set_value_led(Math.round(colorBotLeft.b * 255))
                    else if(lightController.getSelected().botLeft == false){
                        if (leftControl != null)
                            bl = leftControl
                        else
                            bl = mainControl
                    }
                    if (lightController.getSelected().botRight == true)
                        br = set_value_led(Math.round(colorBotRight.r * 255))+","+set_value_led(Math.round(colorBotRight.g * 255))+","+set_value_led(Math.round(colorBotRight.b * 255))
                    else if(lightController.getSelected().botRight == false) {
                        if (rightControl != null)
                            br = rightControl
                        else
                            br = mainControl
                    }
                    //console.debug("SOCKET_STAB : "+switchStab.on)
                    if (left == 0 && right == 0 && switchStab.on == true) {
                        var output = Stabilization.calculateStabilization(psi, theta, phi);
                        var finalOutput = setMotorFromStab(output)
                        socket.sendStringData("["+set_value(finalOutput["left"])+","+set_value(finalOutput["right"])+","+ct+","+fl+","+fr+","+bl+","+br+"]")
                        //console.debug("["+set_value(finalOutput["left"])+","+set_value(finalOutput["right"])+","+ct+","+fl+","+fr+","+bl+","+br+"]")
                    } else {
                        socket.sendStringData("["+set_value(left)+","+set_value(right)+","+ct+","+fl+","+fr+","+bl+","+br+"]")
                        //console.debug("["+set_value(left)+","+set_value(right)+","+ct+","+fl+","+fr+","+bl+","+br+"]")
                    }
                }
            }
        }


        /***********************************************/

//        StopWatch {
//            id: stopWatch

//            anchors.top: parent.top
//            anchors.left: parent.left
//            anchors.leftMargin: 0.5 * Screen.logicalPixelDensity

//            width: 70 * Screen.logicalPixelDensity
//            height: 25 * Screen.logicalPixelDensity
//        }

        // robot light controller (LightControl.qml)
//Silencing the stabilisation button
        Rectangle {
            width: lightController.width
            anchors.left: lightController.left
            anchors.bottom: lightController.top
            anchors.bottomMargin: 20
            height: 30
            color: "transparent"
            z: 0
            //Component for the Stabilisation toggle
            Text {
                id: name
                text: qsTr("Stabilization : ")
                font.pixelSize: 25
                font.bold: true
                color: "#B1D02F"
                anchors.verticalCenter: parent.verticalCenter
                visible: false
            }
            SwitchMaterial{
                id: switchStab
                scale: 1.5
                z: 5
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                visible: false
            }
            MouseArea {
                z: 2
                anchors.fill: parent
                onClicked: {
                    //switchStab.toggle()
                }
            }

        }

        LightControl {
            id: lightController
            height: parent.height * 0.5 + 10
            width: parent.height* 0.5 + 25
            anchors.right: parent.right
            anchors.rightMargin: 50
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
        }

        // colorPicker for lightcontroller
        Item {
            id: colorpicker
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height / 1.6
            width: (height) * 9/14  // (height * ratio colorDialogTab)

            // colorPicker
            ColorDialogTab {
                id: colorSelector
                onColorChanged: {
                    console.debug("color: "+color+"  prev_color: "+lightController.prevColor)
                    lightController.changeColor(color, selected)
                    selected_main = selected
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                visible: false
            }
        }

        // SCANNER
        Scanner {
            id: scanner
            onSelected: {
                socket.connected = false
                socket.setService(remoteService)
                socket.connected = true
                stackView.pop()
            }
        }


        BluetoothSocket {
            id: socket
            connected: true
            objectName: "qml_btSocket"
            onSocketStateChanged: {

            }
            // receive arduino info
            onDataAvailable: {
                var currentData;
                var source = "";
                currentData = stringData;
                if (currentData.toString()[0] == "[" && recordData.isRecording == true && recordData.gameInput != "" && recordData.nameInput != "") {
                    currentData.push("test 1");
                    currentData.push("push_test");
                    if (recordData.fornameInput != "")
                        source = "/sdcard/leka/"+Qt.formatDateTime(new Date(), "yyyy_MM_dd")+"_"+recordData.fornameInput+"_"+recordData.nameInput+"_"+recordData.gameInput + ".txt";
                    else
                        source = "/sdcard/leka/"+Qt.formatDateTime(new Date(), "yyyy_MM_dd")+"_"+recordData.nameInput+"_"+recordData.gameInput + ".txt";

                    FileIO.save(source, currentData.toString());
                }
                //FileIO.save("/home/erwan/Desktop/test.txt"+Qt.formatDateTime(new Date(), "yyyy_MM_dd")+"_"+recordData.nameInput+"_"+recordData.gameInput, currentData.toString());

                try {
                    var parsed = JSON.parse(currentData);
                    console.debug("parsed : " + parsed);
                    phi = parseInt(parsed[4]);
                    theta = parseInt(parsed[5]);
                    psi = parseInt(parsed[6]);
                    console.debug("PSI : (deg?)"+psi)
                } catch(err) {
                    if (err)
                        console.debug("ERROR :(    : " + err)
                }
            }

            onStringDataChanged: {

            }
        } //End of BluetootSocket

        Rectangle {
            color: "transparent"
            anchors.top: parent.top
            anchors.topMargin: 0
            width: parent.width
            height: 25 * Screen.logicalPixelDensity

            Text {
                //text: socket.connected ? socket.service.deviceName : ""
                text: ""
                visible: socket.connected
                font.pointSize: 35
                anchors.right: btScanButton.left
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter
            }

            ImgButton {
                id: btScanButton
                width: height * 0.7
                height: 15 * Screen.logicalPixelDensity
                anchors.right: parent.right
                anchors.rightMargin: mainPageWraper.width * 0.01
                anchors.verticalCenter: parent.verticalCenter
                imgSrc: "pictures/btScanButton.png"
                ColorOverlay {
                    anchors.fill: btScanButton
                    source: btScanButton
                    color: "green"

                    visible: socket.connected?true:false
                }

                onClicked: {  // OPEN BT MENU
                    stackView.push({item:scanner, immediate: true, replace: true})
                }
            }

        }
    } /// *** End of Main Item Wrapper ***

/*    Loader {
        width: 500
        height: parent.height
        anchors.right: parent.right
        z: 99999
        id: pageLoader
        source: "Scanner.qml"
    }
*/
    StackView {
        id: stackView
        initialItem: mainView
        focus: true
        anchors.fill: parent
        Keys.onReleased: {
            console.debug(event.key)
            if (event.key === Qt.Key_Back && stackView.depth > 1) {
                stackView.pop()
                event.accepted = true
                console.debug("Back key pressed.")
            }
        }
    }
}
