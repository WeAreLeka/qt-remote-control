#include "Header/games.h"


Games::Games(): QObject()
{
//    QQmlEngine engine;
//    QQmlComponent component(&engine,
//    QUrl::fromLocalFile("main.qml"));
//    QObject *_mainObject = component.create();
     //_mainObject = component.create();

     //qml_btSocket = rootObject->findChild<QObject*>("qml_btSocket");
}


void Games::launchGame(_GameTitles gameName){

    switch(gameName){
     case Rainbow:
        sendMessage('R');
    }
}

void Games::sendMessage(char gameID){


    QString str_msg= "";
    str_msg.prepend("<");
    str_msg.append(">");
    str_msg.insert(1,gameID);

    QVariant returnedValue;
    QVariant msg = str_msg;

    qDebug() << str_msg;

//    if(qml_btSocket){
//        //qml_btSocket->sendStringData("<R>");
//        QMetaObject::invokeMethod(qml_btSocket, "sendStringData",
//                Q_RETURN_ARG(QVariant, returnedValue),
//                Q_ARG(QVariant, msg));
//    }
        //qml_btSocket->sendStringData("<R>");
//        QMetaObject::invokeMethod(qml_btSocket, "sendStringData",
//                Q_RETURN_ARG(QVariant, returnedValue),
//                Q_ARG(QVariant, msg));

//        qDebug() << returnedValue;

//    QQmlProperty property(qml_btSocket,"stringData");
//    property.write(msg);

}
