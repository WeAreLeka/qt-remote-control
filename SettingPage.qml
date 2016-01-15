import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "Database.js" as Db

Rectangle {
    anchors.fill: parent
    id: root

    function initSetting() {
        leka.clear()
        Db.init_people()
        //Db.resetPeople()
        var all = Db.getPeople();
        //console.debug(JSON.stringify(all))
        var etabs = [];
        for (var i=0; i<all.length; i++){
            if (etabs.indexOf(all[i]["Etab"]) == -1){
                etabs.push(all[i]["Etab"])
            }
        }
        for (var j=0; j<etabs.length; j++){
            for (var k=0; k<all.length; k++){
                if (all[k].Etab == etabs[j])
                    addElement(all[k].Name, all[k].Surname, all[k].Etab)
            }
            leka.append({"name": "", "surname": "", "etablissement": etabs[j], "isVisible": "true", "type":"end"});
        }
        leka.append({"name": "", "surname": "", "etablissement": "Ajouter un etablissement", "isVisible": "true", "type":"addEtab"});
    }

    function removePeople(Etab, Name, Surname) {
        Db.deletePeople(Etab, Name, Surname);
        leka.clear()
        initSetting()
    }

    function addElement(name, surname, etablissement) {
        leka.append({"name": name, "surname": surname, "etablissement": etablissement, "isVisible": "true", "type":"people"});
    }

    Component.onCompleted: {
        initSetting()
    }


    Rectangle {
        id: header
        color: "#56AED4"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        height: parent.height * 0.1
        z: 2

        Image {
            id: backButton
            source: "backButton.svg"
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.01
            height: parent.height * 0.6
            anchors.verticalCenter: parent.verticalCenter
            width: height
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    stackView.push({item:mainView, immediate: true, replace: true})
                }
            }
        }
    }

    Rectangle {
        id: mainRect
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        height: parent.height * 0.9
        width: parent.width * 0.8
        anchors.topMargin: parent.height * 0.1
        color: "#EAEAEA"

        function closeEtab(etabName) {
            for (var i=0; i<leka.count; i++) {
                if (leka.get(i).etablissement == etabName) {
                    leka.get(i).isVisible = "false";
                }
            }
        }
        function openEtab(etabName) {
            for (var i=0; i<leka.count; i++) {
                if (leka.get(i).etablissement == etabName) {
                    leka.get(i).isVisible = "true";
                }
            }
        }



        Rectangle {
            id: container
            anchors.fill: parent
            width: parent.width * 0.8
            color: "#EAEAEA"
            ListModel {
                id: leka
                /*                ListElement { name: "jean"; surname: "doe"; etablissement: "etablissement1"; isVisible: "true" }
                ListElement { name: "pierre"; surname: "doe"; etablissement: "etablissement1"; isVisible: "true" }
                ListElement { name: "michel"; surname: "doe"; etablissement: "etablissement1";isVisible: "true" }
                ListElement { type: "end"; name: ""; surname: ""; etablissement: "etablissement1";isVisible: "true" }

                ListElement { name: "philip"; surname: "doe"; etablissement: "etablissement2";isVisible: "true" }
                ListElement { name: "marine"; surname: "doe"; etablissement: "etablissement2";isVisible: "true" }
                ListElement { name: "ladislas"; surname: "doe"; etablissement: "etablissement2";isVisible: "true" }
                ListElement { name: "bertrand"; surname: "doe"; etablissement: "etablissement2";isVisible: "true" }
                ListElement { name: "arielle"; surname: "doe"; etablissement: "etablissement2";isVisible: "true" }
                ListElement { name: "jose"; surname: "doe"; etablissement: "etablissement2";isVisible: "true" }
                ListElement { type: "end"; name: ""; surname: ""; etablissement: "etablissement2";isVisible: "true" }

                ListElement { name: "gareth"; surname: "doe"; etablissement: "etablissement3";isVisible: "true" }
                ListElement { name: "alexandre"; surname: "doe"; etablissement: "etablissement3";isVisible: "true" }
                ListElement { name: "julien"; surname: "doe"; etablissement: "etablissement3";isVisible: "true" }
                ListElement { type: "end"; name: ""; surname: ""; etablissement: "etablissement3";isVisible: "true" } */
            }

            // The delegate for each section header
            Component {
                id: sectionHeading
                Rectangle {
                    id: currentRoot
                    property bool open: true
                    width: container.width * 0.8
                    anchors.left: parent.left
                    anchors.leftMargin: container.width * 0.1
                    height: 20 * Screen.logicalPixelDensity
                    color: "white"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (open == true) {
                                closeArrow.start()
                                mainRect.closeEtab(section);
                                open = false;
                            } else if (open == false) {
                                openArrow.start()
                                mainRect.openEtab(section);
                                open = true;
                            }
                        }
                    }
                    Image {
                        id: arrowEtab
                        source: "arrow.svg"
                        anchors.verticalCenter: parent.verticalCenter
                        sourceSize.width: height
                        sourceSize.height: parent.height * 0.8
                        rotation:  0
                        PropertyAnimation { id: openArrow; target: arrowEtab; property: "rotation"; to: 0; duration: 200 }
                        PropertyAnimation { id: closeArrow; target: arrowEtab; property: "rotation"; to: -90; duration: 200 }

                    }

                    Rectangle {
                        width: parent.width * 0.9
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: 2
                        color: "grey"
                        anchors.top: parent.top
                    }

                    Text {
                        text: section
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20 * Screen.logicalPixelDensity
                        font.bold: true
                        font.pixelSize: 6 * Screen.logicalPixelDensity
                    }
                }
            }



            ListView {
                id: view
                anchors.top: parent.top
                anchors.bottom: buttonBar.top
                width: container.width * 0.8
                model: leka
                delegate: Rectangle {
                    property string isVisible2: isVisible
                    id: currentContainer
                    onIsVisible2Changed: {
                        if (isVisible2 == "true") {
                            openName.start()
                        } else if(isVisible2 == "false") {
                            closeName.start()
                        }
                    }
                    height: 20* Screen.logicalPixelDensity
                    width: container.width * 0.8
                    anchors.left: parent.left
                    anchors.leftMargin: container.width * 0.1
                    color: "white"
                    PropertyAnimation { id: closeName; target: currentContainer; property: "height"; to: 0; duration: 200 }
                    PropertyAnimation { id: openName; target: currentContainer; property: "height"; to: 20 * Screen.logicalPixelDensity; duration: 200 }

                    Rectangle {
                        width: parent.width
                        height: parent.height
                        visible: type=="end"?true:false
                        z: 100

                        Image {
                            id: add
                            source: "add.svg"
                            visible: isVisible2=="true"?true: false
                            anchors.verticalCenter: parent.verticalCenter
                            sourceSize.width: height
                            sourceSize.height:  isVisible2=="true"?10 * Screen.logicalPixelDensity:0
                            anchors.left: parent.left
                            anchors.leftMargin: parent.width * 0.05
                        }

                        TextField {
                            id: nameInput
                            width: parent.width * 0.3
                            height: parent.height
                            style: TextFieldStyle {
                                textColor: "#F39016"
                                font.pixelSize: 20
                                background: Rectangle {
                                    radius: 0
                                    implicitWidth: parent.width * 0.4
                                    implicitHeight: parent.height
                                    color: "transparent"
                                }
                            }

                            anchors.verticalCenter: parent.verticalCenter
                            horizontalAlignment: TextInput.AlignHCenter
                            placeholderText: qsTr("Name")
                        }
                        TextField {
                            id: surnameInput
                            width: parent.width * 0.3
                            anchors.left: nameInput.right
                            height: parent.height
                            style: TextFieldStyle {
                                textColor: "#F39016"
                                font.pixelSize: 20
                                background: Rectangle {
                                    radius: 0
                                    implicitWidth: parent.width * 0.4
                                    implicitHeight: parent.height
                                    color: "transparent"
                                }
                            }

                            anchors.verticalCenter: parent.verticalCenter
                            horizontalAlignment: TextInput.AlignHCenter
                            placeholderText: qsTr("Surname")
                            onAccepted: {
                                if (surnameInput.text != "" && nameInput.text != "") {
                                    Db.insertPeople(etablissement, nameInput.text, surnameInput.text)
                                    leka.append({"name": nameInput.text, "surname": surnameInput.text, "etablissement": etablissement, "isVisible": "true", "type":"other"});
                                    initSetting()
                                }
                            }
                        }

                        Rectangle {
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: parent.width * 0.1
                            width: parent.width * 0.2
                            height:  isVisible2=="true"?10 * Screen.logicalPixelDensity:0
                            color: "#F39016"
                            Text {
                                text: qsTr("Ajouter")
                                anchors.centerIn: parent
                                color: "white"
                                font.bold: true
                                font.pixelSize: 4 * Screen.logicalPixelDensity
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    console.debug(etablissement)
                                    if (surnameInput.text != "" && nameInput.text != "") {
                                        Db.insertPeople(etablissement, nameInput.text, surnameInput.text)
                                        leka.append({"name": nameInput.text, "surname": surnameInput.text, "etablissement": etablissement, "isVisible": "true", "type":"other"});
                                        initSetting()
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: parent.height
                        visible: type=="addEtab"?true:false

                        z: 100

                        Image {
                            id: addEtab
                            source: "add.svg"
                            //                            visible: isVisible2=="true"?true: false
                            visible: false
                            anchors.verticalCenter: parent.verticalCenter
                            sourceSize.width: height
                            sourceSize.height:  isVisible2=="true"?10 * Screen.logicalPixelDensity:0
                            anchors.left: parent.left
                            anchors.leftMargin: parent.width * 0.05
                        }

                        TextField {
                            id: addEtabEtabInput
                            width: parent.width * 0.2
                            height: parent.height
                            anchors.left: parent.left
                            anchors.leftMargin:  parent.width * 0.08
                            style: TextFieldStyle {
                                textColor: "#F39016"
                                font.pixelSize: 20
                                background: Rectangle {
                                    radius: 0
                                    implicitWidth: parent.width * 0.4
                                    implicitHeight: parent.height
                                    color: "transparent"
                                }
                            }

                            anchors.verticalCenter: parent.verticalCenter
                            horizontalAlignment: TextInput.AlignHCenter
                            placeholderText: qsTr("Etab Name")
                        }
                        TextField {
                            id: addEtabNameInput
                            width: parent.width * 0.2
                            anchors.left: addEtabEtabInput.right
                            height: parent.height
                            style: TextFieldStyle {
                                textColor: "#F39016"
                                font.pixelSize: 20
                                background: Rectangle {
                                    radius: 0
                                    implicitWidth: parent.width * 0.4
                                    implicitHeight: parent.height
                                    color: "transparent"
                                }
                            }

                            anchors.verticalCenter: parent.verticalCenter
                            horizontalAlignment: TextInput.AlignHCenter
                            placeholderText: qsTr("Name")
                        }
                        TextField {
                            id: addEtabSurnameInput
                            width: parent.width * 0.2
                            anchors.left: addEtabNameInput.right
                            height: parent.height
                            style: TextFieldStyle {
                                textColor: "#F39016"
                                font.pixelSize: 20
                                background: Rectangle {
                                    radius: 0
                                    implicitWidth: parent.width * 0.4
                                    implicitHeight: parent.height
                                    color: "transparent"
                                }
                            }
                            onAccepted: {
                                if (addEtabSurnameInput.text != "" && addEtabNameInput.text != "" && addEtabEtabInput.text != "") {
                                    Db.insertPeople(addEtabEtabInput.text, addEtabNameInput.text, addEtabSurnameInput.text)
                                    leka.append({"name": addEtabNameInput.text, "surname": addEtabSurnameInput.text, "etablissement": addEtabEtabInput.text, "isVisible": "true", "type":"other"});
                                    initSetting()
                                }
                            }

                            anchors.verticalCenter: parent.verticalCenter
                            horizontalAlignment: TextInput.AlignHCenter
                            placeholderText: qsTr("Surname")
                        }
                        Rectangle {
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: parent.width * 0.1
                            width: parent.width * 0.2
                            height:  isVisible2=="true"?10 * Screen.logicalPixelDensity:0
                            color: "#F39016"
                            Text {
                                text: qsTr("Ajouter")
                                anchors.centerIn: parent
                                color: "white"
                                font.bold: true
                                font.pixelSize: 4 * Screen.logicalPixelDensity
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    console.debug(etablissement)
                                    if (addEtabSurnameInput.text != "" && addEtabNameInput.text != "" && addEtabEtabInput.text != "") {
                                        Db.insertPeople(addEtabEtabInput.text, addEtabNameInput.text, addEtabSurnameInput.text)
                                        leka.append({"name": addEtabNameInput.text, "surname": addEtabSurnameInput.text, "etablissement": addEtabEtabInput.text, "isVisible": "true", "type":"other"});
                                        initSetting()
                                    }
                                }
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (type != "end") {
                                recordData.setNames(name, surname);
                                stackView.push({item:mainView, immediate: true, replace: true})
                                console.debug(name + "   " + surname)
                            }
                        }
                    }

                    Image {
                        id: arrowChild
                        visible: type=="end"?false:true
                        source: "arrow.svg"
                        anchors.verticalCenter: parent.verticalCenter
                        sourceSize.width: height
                        sourceSize.height: isVisible2=="true"?15 * Screen.logicalPixelDensity:0
                        rotation: -90
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width * 0.05
                    }

                    Text {
                        text: name + "  " + surname;
                        visible: type=="end"?false:true
                        anchors.left: parent.left
                        anchors.leftMargin: 40 * Screen.logicalPixelDensity
                        anchors.verticalCenter: currentContainer.verticalCenter
                        font.pixelSize: 6 * Screen.logicalPixelDensity
                    }
                    Image {
                        id: remove
                        source: "delete.svg"
                        visible: isVisible2=="true"?true: false
                        anchors.verticalCenter: parent.verticalCenter
                        sourceSize.width: height
                        sourceSize.height:  isVisible2=="true"?10 * Screen.logicalPixelDensity:0
                        anchors.right: parent.right
                        anchors.rightMargin: 5 * Screen.logicalPixelDensity
                        MouseArea {
                            anchors.fill: parent
                            onClicked: removePeople(etablissement, name, surname)
                        }
                    }
                }

                section.property: "etablissement"
                section.criteria: ViewSection.FullString
                section.delegate: sectionHeading
            }

            Row {
                id: buttonBar
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 1
                spacing: 1

            }
        }
    }
}

