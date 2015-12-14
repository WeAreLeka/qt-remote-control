import QtQuick 2.4
// adding localstorage :)
import QtQuick.LocalStorage 2.0 as Sql

// DEFINE ALL COLORS FOR THE right ear
Rectangle {
    id: main_right_color
    anchors.topMargin: 10
    anchors.rightMargin: 10
    width: 106; height:  218
    color: "transparent"
    anchors.right: parent.right

    Grid {
        horizontalItemAlignment: Grid.AlignHCenter
        columns: 2
        spacing: 6

        Rectangle {
            color: "#ffff00"; id: right_yellow; width: 50; height: 50; border.width: 1;
            MouseArea {
                anchors.fill: parent
                onClicked: { main_right_color.color = right_yellow.color;
                    var db=Sql.LocalStorage.openDatabaseSync("TestDB", "", "Description", 100000);
                    db.transaction( function(tx) {
                        console.debug("UPDATED");
                        var rs = tx.executeSql("UPDATE DATA SET value='#ffff00' WHERE type='colorRight'");
                    });
                }
            }
        }
        Rectangle {
            color: "#00ff00"; id: right_green; width: 50; height: 50; border.width: 1;
            MouseArea {
                anchors.fill: parent
                onClicked: { main_right_color.color = right_green.color;
                    var db=Sql.LocalStorage.openDatabaseSync("TestDB", "", "Description", 100000);
                    db.transaction( function(tx) {
                        console.debug("UPDATED");
                        var rs = tx.executeSql("UPDATE DATA SET value='#00ff00' WHERE type='colorRight'");
                    });
                }
            }
        }
        Rectangle {
            color: "#ff0000"; id: right_red; width: 50; height: 50; border.width: 1;
            MouseArea {
                anchors.fill: parent
                onClicked: { main_right_color.color = right_red.color;
                    var db=Sql.LocalStorage.openDatabaseSync("TestDB", "", "Description", 100000);
                    db.transaction( function(tx) {
                        console.debug("UPDATED");
                        var rs = tx.executeSql("UPDATE DATA SET value='#ff0000' WHERE type='colorRight'");
                    });
                }
            }
        }
        Rectangle {
            color: "#ff7ff0"; id: right_orange; width: 50; height: 50; border.width: 1;
            MouseArea {
                anchors.fill: parent
                onClicked: {main_right_color.color = right_orange.color;
                    var db=Sql.LocalStorage.openDatabaseSync("TestDB", "", "Description", 100000);
                    db.transaction( function(tx) {
                        console.debug("UPDATED");
                        var rs = tx.executeSql("UPDATE DATA SET value='#ff7ff0' WHERE type='colorRight'");
                    });
                }
            }
        }
        Rectangle {
            color: "#0000ff"; id: right_blue; width: 50; height: 50; border.width: 1;
            MouseArea {
                anchors.fill: parent
                onClicked: {main_right_color.color = right_blue.color;
                    var db=Sql.LocalStorage.openDatabaseSync("TestDB", "", "Description", 100000);
                    db.transaction( function(tx) {
                        console.debug("UPDATED");
                        var rs = tx.executeSql("UPDATE DATA SET value='#0000ff' WHERE type='colorRight'");
                    });
                }
            }
        }
        Rectangle {
            color: "#700a99"; id: right_purple; width: 50; height: 50; border.width: 1;
            MouseArea {
                anchors.fill: parent
                onClicked: {main_right_color.color = right_purple.color;
                    var db=Sql.LocalStorage.openDatabaseSync("TestDB", "", "Description", 100000);
                    db.transaction( function(tx) {
                        console.debug("UPDATED");
                        var rs = tx.executeSql("UPDATE DATA SET value='#700a99' WHERE type='colorRight'");
                    });
                }
            }
        }
        Rectangle { // PUT THE NEXT RECTANGLE ON THE RIGHT
            color: "transparent"; width: 50; height: 50;
        }
        Rectangle {
            color: "transparent"; id: right_remove; width: 50; height: 50; border.width: 1;
            Text {
                text: "Reset"
                anchors.horizontalCenter: parent.horizontalCenter
                y: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {main_right_color.color = "transparent";
                    var db=Sql.LocalStorage.openDatabaseSync("TestDB", "", "Description", 100000);
                    db.transaction( function(tx) {
                        console.debug("UPDATED");
                        var rs = tx.executeSql("UPDATE DATA SET value='transparent' WHERE type='colorRight'");
                    });
                }
            }
        }
    }
}
