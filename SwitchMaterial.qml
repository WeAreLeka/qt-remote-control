import QtQuick 2.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0

Item {
    id: toggleswitch
    width: background.width; height: background.height

    property bool on: false

    function toggle() {
        if (toggleswitch.state == "on")
            toggleswitch.state = "off";
        else
            toggleswitch.state = "on";
    }

    function releaseSwitch() {
        if (knob.x == 1) {
            if (toggleswitch.state == "off") return;
        }
        if (knob.x == 78) {
            if (toggleswitch.state == "on") return;
        }
        toggle();
    }

    Image {
        id: background
        source: "pictures/switchBackground.png"
        width: 15 * Screen.logicalPixelDensity
        height: 5.6 * Screen.logicalPixelDensity
        visible: on == true?false:true
        smooth: true
        MouseArea { anchors.fill: parent; onClicked: toggle() }
    }
    ColorOverlay {
        id: backgroundOverlay
        visible: on == true?true:false
        anchors.fill: background
        source: background
        smooth: true
        color: "#B0AFAF"
    }

    Rectangle {
        id: knob
        x: -1; y: 0
        height: 8 * Screen.logicalPixelDensity
        width: height
        radius: width / 2
        anchors.verticalCenter: parent.verticalCenter
        color: "#F1F1F1"
        MouseArea {
            anchors.fill: parent
            drag.target: knob; drag.axis: Drag.XAxis; drag.minimumX: -1; drag.maximumX: 7.5 * Screen.logicalPixelDensity
            onClicked: toggle()
            onReleased: releaseSwitch()
        }
    }

    states: [
        State {
            name: "on"
            PropertyChanges { target: knob; x: 7.5 * Screen.logicalPixelDensity}
            PropertyChanges { target: toggleswitch; on: true }
            PropertyChanges { target: backgroundOverlay; color: "#E5EAD1" }
            PropertyChanges { target: knob; color: "#B1D13C" }
        },
        State {
            name: "off"
            PropertyChanges { target: knob; x: -1 }
            PropertyChanges { target: toggleswitch; on: false }
            PropertyChanges { target: backgroundOverlay; color: "#B0AFAF" }
            PropertyChanges { target: knob; color: "#F1F1F1" }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 200 }
    }
}
