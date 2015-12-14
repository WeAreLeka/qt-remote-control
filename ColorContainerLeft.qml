import QtQuick 2.4
// adding localstorage :)
import QtQuick.LocalStorage 2.0 as Sql

// DEFINE ALL COLORS FOR THE LEFT EAR
Rectangle {
    id: main_left_color
    anchors.topMargin: 10
    anchors.leftMargin: 10
    width: 106; height:  218
    color: "transparent"
    anchors.left: parent.left

    Grid {
        horizontalItemAlignment: Grid.AlignHCenter
        columns: 2
        spacing: 6

        Rectangle {
            color: "#00ff00"; id: left_green; width: 50; height: 50; border.width: 1;
            MouseArea {
                anchors.fill: parent
                onClicked: { main_left_color.color = left_green.color;
                    var db=Sql.LocalStorage.openDatabaseSync("TestDB", "", "Description", 100000);
                    db.transaction( function(tx) {
                        console.debug("UPDATED");
                        var rs = tx.executeSql("UPDATE DATA SET value='#00ff00' WHERE type='colorLeft'");
                    });
                    printValues();
                }

            }
            //READ DATABASE ?
        }

        Rectangle {
            color: "#ffff00"; id: left_yellow; width: 50; height: 50; border.width: 1;
            MouseArea {
                anchors.fill: parent
                onClicked: { main_left_color.color = left_yellow.color;
                    var db=Sql.LocalStorage.openDatabaseSync("TestDB", "", "Description", 100000);
                    db.transaction( function(tx) {
                        console.debug("UPDATED");
                        var rs = tx.executeSql("UPDATE DATA SET value='#ffff00' WHERE type='colorLeft'");
                    });
                    printValues();
                }
            }
        }

        Rectangle {
            color: "#ff7ff0"; id: left_orange; width: 50; height: 50; border.width: 1;
            MouseArea {
                anchors.fill: parent
                onClicked: { main_left_color.color = left_orange.color;
                    var db=Sql.LocalStorage.openDatabaseSync("TestDB", "", "Description", 100000);
                    db.transaction( function(tx) {
                        console.debug("UPDATED");
                        var rs = tx.executeSql("UPDATE DATA SET value='#ff7ff0' WHERE type='colorLeft'");
                    });
                }
            }
        }
        Rectangle {
            color: "#ff0000"; id: left_red; width: 50; height: 50; border.width: 1;
            MouseArea {
                anchors.fill: parent
                onClicked: {main_left_color.color = left_red.color;
                    var db=Sql.LocalStorage.openDatabaseSync("TestDB", "", "Description", 100000);
                    db.transaction( function(tx) {
                        console.debug("UPDATED");
                        var rs = tx.executeSql("UPDATE DATA SET value='#ff0000' WHERE type='colorLeft'");
                    });
                }
            }
        }
        Rectangle {
            color: "#700a99"; id: left_purple; width: 50; height: 50; border.width: 1;
            MouseArea {
                anchors.fill: parent
                onClicked: {main_left_color.color = left_purple.color;
                    var db=Sql.LocalStorage.openDatabaseSync("TestDB", "", "Description", 100000);
                    db.transaction( function(tx) {
                        console.debug("UPDATED");
                        var rs = tx.executeSql("UPDATE DATA SET value='#700a99' WHERE type='colorLeft'");
                    });
                }
            }
        }
        Rectangle {
            color: "#0000ff"; id: left_blue; width: 50; height: 50; border.width: 1;
            MouseArea {
                anchors.fill: parent
                onClicked: {main_left_color.color = left_blue.color;
                    var db=Sql.LocalStorage.openDatabaseSync("TestDB", "", "Description", 100000);
                    db.transaction( function(tx) {
                        console.debug("UPDATED");
                        var rs = tx.executeSql("UPDATE DATA SET value='#0000ff' WHERE type='colorLeft'");
                    });
                }
            }
        }
        Rectangle {
            color: "transparent"; id: left_remove; width: 50; height: 50; border.width: 1;
            Text {
                text: "Reset"
                anchors.horizontalCenter: parent.horizontalCenter
                y: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {main_left_color.color = "transparent";
                    var db=Sql.LocalStorage.openDatabaseSync("TestDB", "", "Description", 100000);
                    db.transaction( function(tx) {
                        console.debug("UPDATED");
                        var rs = tx.executeSql("UPDATE DATA SET value='transparent' WHERE type='colorLeft'");
                    });

                }
            }
        }
    }
}
