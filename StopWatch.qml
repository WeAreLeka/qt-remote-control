import QtQuick 2.5

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
        seconds = Math.round(seconds * 100) / 100
        var result = (hours < 10 ? "0" + hours : hours);
        result += ":" + (minutes < 10 ? "0" + minutes : minutes);
        result += ":" + (seconds  < 10 ? "0" + seconds : seconds);
        return result;
    }

    Component.onCompleted: time.text = "--:--:--"

    Rectangle {
        id: resumeRect
        width: parent.width * 0.6
        height: parent.height
        opacity: 0.5
        Rectangle {
            id: resume
            color: "skyBlue"
            width: parent.width
            height: parent.height
            anchors.left: parent.left
            visible: false
            Image {
                source: "timerStart.svg"
                smooth: true
                height: parent.height * 0.6
                width: parent.height * 0.6
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.2
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    Rectangle {
        width: parent.width * 0.4
        height: parent.height
        anchors.left: resumeRect.right

        Rectangle {
            id: stop
            color: "red"
            width: parent.width
            height: parent.height
            visible: false
            Image {
                source: "timerStop.svg"
                smooth: true
                height: parent.height * 0.6
                width: parent.height * 0.6
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.2
                anchors.horizontalCenter: parent.horizontalCenter
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
                    pause = Math.round((pause_end - pause_begin) / 1000) + pause
                else if (pause != 0)
                    pause = pause + 0
                else if (pause == 0)
                    pause = 0

                console.debug("PAUSE : " + pause)

                timer.start()
                resume.visible = false
                stop.visible = false
                isStart = true

                if (touchPoints[0].x > parent.width * 0.6) {
                    begin = new Date().valueOf()
                    pause = 0
                }

            }
            else if(isStart == true) {
                console.debug("STOPPPPPPPPPPPPP")
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
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: resumeRect.horizontalCenter
    }
}
