TEMPLATE = app
QT += qml quick widgets svg bluetooth core
QT += gui
QT += opengl
!no_desktop: QT += widgets
#QT += sql
SOURCES += Source/main.cpp \
    Source/fileio.cpp \
    Source/Stabilization.cpp \
    Source/filters.cpp \
#    Source/bluetooth.cpp \
    Source/runningaverage.cpp

TARGET = remote_simplified

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    android/AndroidManifest.xml \
    android/res/values/libs.xml \
    android/build.gradle

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

HEADERS += \
    Header/fileio.h \
    Header/Stabilization.h \
    Header/Filters.h \
#    Header/bluetooth.h \
    Header/RunningAverage.h

