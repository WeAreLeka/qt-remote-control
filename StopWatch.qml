import QtQuick 2.5

Item {
    property double begin
    property bool isStart: false
    property string text

    function setTime(value) {
        value = Math.round(value);
        var hours   = Math.floor(value / 3600);
        var minutes = Math.floor((value - (hours * 3600)) / 60);
        var seconds = value - (hours * 3600) - (minutes * 60);

        // round seconds
        seconds = Math.round(seconds * 100) / 100

        var result = (hours < 10 ? "0" + hours : hours);
        result += ":" + (minutes < 10 ? "0" + minutes : minutes);
        result += ":" + (seconds  < 10 ? "0" + seconds : seconds);
        console.debug(result);
        return result;
    }

    Rectangle {
        width: parent.width
        height: parent.height
        color: "skyBlue"
        Rectangle {
            id: resume
            width: parent.width / 2
            height: parent.height
            anchors.left: parent.left
            visible: false
            Image {
                source: "timerStart.svg"
                smooth: true
                height: parent.height * 0.6
                width: parent.height * 0.6
                anchors.left: parent.left
                anchors.leftMargin: parent.height * 0.2
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.2
            }
        }
        Rectangle {
            id: stop
            width: parent.width / 2
            height: parent.height
            anchors.left: resume.right
            anchors.leftMargin: 0
            visible: false
            Image {
                source: "timerStop.svg"
                smooth: true
                height: parent.height * 0.5
                width: parent.height * 0.5
                anchors.right: parent.right
                anchors.rightMargin: parent.height * 0.25
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.25
            }
        }
    }

    Timer {
        interval: 50
        running: true
        repeat: true
        onTriggered: {
            if (isStart == false) {
                time.text = "--:--:--"
                begin = new Date().valueOf()
            } else {
                time.text = setTime((new Date().valueOf() - begin) / 1000)
            }
        }
    }

    MultiPointTouchArea {
        anchors.fill: parent
        onPressed: {
            if (isStart == false) {
                               begin = new Date().valueOf()
                isStart = true
                if (touchPoints[0].x > parent.width / 2) { // if right side clicked
                    console.debug("RIGHT CLICKED :D")
                } else {
                    console.debug("LEFT CLICKED :D")
                    begin = new Date().valueOf()
                }
                stop.visible = false
                resume.visible = false
            }
            else if(isStart == true) {
//                begin = new Date().valueOf()
                isStart = false
                stop.visible = true
                resume.visible = true
            }
        }
    }

    Text {
        id: time;
        text: text
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
