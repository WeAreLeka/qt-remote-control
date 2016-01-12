import QtQuick 2.5
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2

Item {
    property double begin
    property bool isStart: false
    property string text
    property double pause_begin: 0
    property double pause_end: 0
    property double pause

    function setTime(value) {
        value = Math.round(value);
        var hours   = Math.floor(value / 3600);
        var minutes = Math.floor((value - (hours * 3600)) / 60);
        var seconds = value - (hours * 3600) - (minutes * 60);
        if (hours<0)hours=0
        if (minutes<0)minutes=0
        if (seconds<0)seconds=0
        seconds = Math.round(seconds * 100) / 100
        var result = (hours < 10 ? "0" + hours : hours);
        result += ":" + (minutes < 10 ? "0" + minutes : minutes);
        result += ":" + (seconds  < 10 ? "0" + seconds : seconds);
        return result;
    }

    Component.onCompleted: time.text = " -- : -- : --"
    Rectangle {
        anchors.fill: parent
        width: parent.width
        height: parent.height
        Rectangle {
            id: resume
//            color: "#4285F4"
            width: parent.width * 0.7
            height: parent.height
            visible: false
            Image {
                id: timerStart
//                source: "timerStart.svg"
                smooth: true
                opacity: 0.5
                height: parent.height * 0.6
                width: parent.height * 0.6
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.2
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Rectangle {
            id: stop
//            color: "#4285F4"
            anchors.left: resume.right
            width: parent.width * 0.3
            height: parent.height
            visible: false
            Image {
                id: reset
                source: "refresh.svg"
                smooth: true
                opacity: 1
                height: parent.height * 0.8
                width: parent.height * 0.8
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.1
                anchors.horizontalCenter: parent.horizontalCenter
            }
            ColorOverlay {
                    anchors.fill: reset
                    source: reset
//                    color: "#FF5252"
                    color: "black"
                }
        }
    }
    Timer {
        id: timer
        interval: 50
        running: true
        repeat: true
        onTriggered: {
            if (isStart == false) {
                begin = new Date().valueOf()
            } else {
                time.text = setTime((new Date().valueOf() - begin) / 1000 - pause)
            }
        }
    }

    MultiPointTouchArea {
        anchors.fill: parent
        onPressed: {
            if (isStart == false) {
                console.debug("STARRRRRRTTTTTTTTT")
                pause_end = new Date().valueOf()
                if (pause_end != undefined && pause_end != 0 && pause_begin != undefined && pause_begin != 0)
                    pause = ((pause_end - pause_begin) / 1000) + pause
                else if (pause != 0)
                    pause = pause + 0
                else if (pause == 0)
                    pause = 0

                console.debug("PAUSE : " + pause)

                timer.start()
                resume.visible = false
                stop.visible = false
                isStart = true

                if (touchPoints[0].x > parent.width * 0.7) {
                    begin = new Date().valueOf()
                    time.text = " -- : -- : --"
                    isStart = false
                    timer.stop()
                    pause_end = new Date().valueOf()
                    pause_begin = new Date().valueOf()
                    pause = 0
                }

            }
            else if(isStart == true) {
                console.debug("STOP")
                pause_begin = new Date().valueOf()
                timer.stop()
                resume.visible = true
                stop.visible = true
                isStart = false
            }
        }
    }

    Text {
        id: time;
        text: text
        color: "#4285F4"
//        color: "white"
        font.bold: true
        font.weight: Font.DemiBold
        font.pixelSize:  5 * Screen.logicalPixelDensity
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

    }
}
