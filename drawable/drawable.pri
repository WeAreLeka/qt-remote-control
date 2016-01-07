android-no-sdk {
    target.path = /data/user/qt
    export(target.path)
    INSTALLS += target
} else:android {
    x86 {
        target.path = /libs/x86
    } else: armeabi-v7a {
        target.path = /libs/armeabi-v7a
    } else {
        target.path = /libs/armeabi
    }
    export(target.path)
    INSTALLS += target
} else:unix {
    isEmpty(target.path) {
        qnx {
            target.path = /tmp/$${TARGET}/bin
        } else {
            target.path = /opt/$${TARGET}/bin
        }
        export(target.path)
    }
    INSTALLS += target
}

export(INSTALLS)

DISTFILES += \
    $$PWD/btScanButton.png \
    $$PWD/doneButton.png \
    $$PWD/logo.png \
    $$PWD/quarter_changed.png \
    $$PWD/quarters_border.png \
    $$PWD/quarters_cut_left_border.png \
    $$PWD/quarters_cut_left.png \
    $$PWD/quarters_cut_right_border.png \
    $$PWD/quarters_cut_right.png \
    $$PWD/quarters.png \
    $$PWD/right.png \
    $$PWD/searchAgain.png \
    $$PWD/backButton.svg \
    $$PWD/refresh.svg \
    $$PWD/reload.svg \
    $$PWD/search.svg \
    $$PWD/timerStart.svg
