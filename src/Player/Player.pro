QT += quick quickcontrols2 multimedia sql websockets

TEMPLATE = app

SOURCES += \
    main.cpp

HEADERS +=

FORMS +=

RESOURCES += \
    mp.qrc

CONFIG += c++11
win32 {
    OTHER_FILES += config/mp.rc
    RC_FILE += config/mp.rc
    TARGET = MiamPlayer-QML
}
unix:!macx {
    TARGET = miam-player-qml
}
macx {
    TARGET = MiamPlayer
    QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.9
}

TRANSLATIONS =

CONFIG(debug, debug|release) {
    win32 {
	LIBS += -L$$PWD/../../lib/debug/win-x64/ -ltag
	LIBS += -L$$OUT_PWD/../Core/debug/ -lCore
	QMAKE_POST_LINK += $${QMAKE_COPY} $$shell_path($$PWD/../Core/mp.ico) $$shell_path($$OUT_PWD/debug/)
    }
    OBJECTS_DIR = debug/.obj
    MOC_DIR = debug/.moc
    RCC_DIR = debug/.rcc
    UI_DIR = $$PWD
}

CONFIG(release, debug|release) {
    win32 {
	LIBS += -L$$PWD/../../lib/release/win-x64/ -ltag
	LIBS += -L$$OUT_PWD/../Core/release/ -lCore
	QMAKE_POST_LINK += $${QMAKE_COPY} $$shell_path($$PWD/../Core/mp.ico) $$shell_path($$OUT_PWD/release/)
    }
    OBJECTS_DIR = release/.obj
    MOC_DIR = release/.moc
    RCC_DIR = release/.rcc
    UI_DIR = $$PWD
}
unix:!macx {
    LIBS += -ltag -L$$OUT_PWD/../Core/ -lmiam-core
    target.path = /usr/bin
    desktop.path = /usr/share/applications
    desktop.files = $$PWD/../../debian/usr/share/applications/miam-player.desktop
    icon64.path = /usr/share/icons/hicolor/64x64/apps
    icon64.files = $$PWD/../../debian/usr/share/icons/hicolor/64x64/apps/application-x-miamplayer.png
    appdata.path = /usr/share/appdata
    appdata.files = $$PWD/../../fedora/miam-player.appdata.xml
    INSTALLS += desktop \
	target \
	icon64 \
	appdata
}
macx {
    LIBS += -L$$PWD/../../lib/osx/ -ltag -L$$OUT_PWD/../Core/ -lmiam-core
    ICON = $$PWD/../../osx/MiamPlayer.icns
    QMAKE_SONAME_PREFIX = @executable_path/../Frameworks
    #1 create Framework and PlugIns directories
    #2 copy third party library: TagLib, QtAV
    #3 copy own libs
    QMAKE_POST_LINK += $${QMAKE_MKDIR} $$shell_path($$OUT_PWD/MiamPlayer.app/Contents/Frameworks/) && \
     $${QMAKE_MKDIR} $$shell_path($$OUT_PWD/MiamPlayer.app/Contents/PlugIns/) && \
     $${QMAKE_COPY} $$shell_path($$PWD/../../lib/osx/libtag.dylib) $$shell_path($$OUT_PWD/MiamPlayer.app/Contents/Frameworks/) && \
     $${QMAKE_COPY} $$shell_path($$OUT_PWD/../Core/libmiam-core.*.dylib) $$shell_path($$OUT_PWD/MiamPlayer.app/Contents/Frameworks/)
}

3rdpartyDir  = $$PWD/../Core/3rdparty
INCLUDEPATH += $$3rdpartyDir
DEPENDPATH += $$3rdpartyDir

INCLUDEPATH += $$PWD/dialogs $$PWD/filesystem $$PWD/playlists $$PWD/views $$PWD/views/tageditor
INCLUDEPATH += $$PWD/../Core

DEPENDPATH += $$PWD/dialogs $$PWD/filesystem $$PWD/playlists $$PWD/views $$PWD/views/tageditor
DEPENDPATH += $$PWD/../Core

DISTFILES += \
    main.qml \
    pages/*.qml
