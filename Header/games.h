#ifndef GAMES_H
#define GAMES_H

#include <QObject>
#include <QQmlComponent>
#include <QQmlEngine>
#include <QString>
#include <qdebug.h>
#include <QQmlProperty>

class Games : public QObject
{
    Q_OBJECT
    //Q_PROPERTY(Games::_GameTitles getGameName READ gameList)


public:
    Games();
    enum _GameTitles{
        Rainbow
    };

    Q_ENUMS(_GameTitles)
    Q_INVOKABLE void launchGame(_GameTitles gameName);

private:
    void sendMessage(char gameID);
    QObject *qml_btSocket;
    QObject *_mainObject;
};

#endif // GAMES_H
