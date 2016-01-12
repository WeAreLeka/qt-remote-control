.pragma library
.import QtQuick.LocalStorage 2.0 as Sql

var db = Sql.LocalStorage.openDatabaseSync("Local Storage Example", "1.0", "Sample database", 100000);

function init() {
    db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS saveStateColors(id VARCHAR(500) PRIMARY KEY, value VARCHAR(500));')
                }
                )
}

function getRecords() {
    var records = []

    db.transaction(
                function(tx) {
                    var rs = tx.executeSql('SELECT * FROM saveStateColors;');
                    for (var i = 0; i < rs.rows.length; i++) {
                        var record = {
                            id: rs.rows.item(i).id,
                            content: rs.rows.item(i).value
                        }
                        records.push(record)
//                        console.debug("GET RECORDS: "+ record.id + record.content)
                    }
//                    return rs
                }
                );

    return records
}

function insertRecord(id, color) {
    db.transaction(
                function(tx) {
                    tx.executeSql('INSERT OR IGNORE INTO saveStateColors VALUES(?, ?);', [ id, color]);
                }
                );
}

function updateRecord(value, id) {
    db.transaction(
                function(tx) {
                    tx.executeSql('UPDATE saveStateColors SET value=? WHERE id=?;', [ value, id ]);
                }
                );
}
