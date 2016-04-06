#include <QtGui/QGuiApplication>
#include <QtQuick/QQuickView>
#include <QSwipeGesture>
#include <QtQml/QQmlEngine>
#include <QtQml/QQmlContext>
#include <QDebug>
#include <QTouchEvent>
#include "Header/fileio.h"
#include "Header/Stabilization.h"
#include <QtOpenGL>

#include <QQmlComponent>

int main(int argc, char *argv[])
{
    QGuiApplication application(argc, argv);

    const QString mainQmlApp = QLatin1String("qrc:/main.qml");
    QQuickView view;
    view.setSource(QUrl(mainQmlApp));
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.rootContext()->setContextProperty("FileIO", new FileIO());
    view.rootContext()->setContextProperty("Stabilization", new Stabilization());
    // Qt.quit() called in embedded .qml by default only emits
    // quit() signal, so do this (optionally use Qt.exit()).
    QObject::connect(view.engine(), SIGNAL(quit()), qApp, SLOT(quit()));
    // view.setGeometry(QRect(100, 100, 360, 480));
    view.showMaximized();

    return application.exec();
}
