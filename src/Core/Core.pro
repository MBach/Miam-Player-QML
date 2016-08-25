QT       += gui multimedia sql

3rdpartyDir  = $$PWD/3rdparty

INCLUDEPATH += $$PWD
INCLUDEPATH += $$3rdpartyDir $$3rdpartyDir/QtAV
DEPENDPATH += $$3rdpartyDir $$3rdpartyDir/QtAV

include(qxt/qxt.pri)

DEFINES += MIAM_PLUGIN

TEMPLATE = lib

win32 {
    TARGET = Core
    CONFIG += dll
    CONFIG(debug, debug|release) {
	LIBS += -L$$PWD/../../lib/debug/win-x64/ -ltag -lQtAV1 -lUser32
    }
    CONFIG(release, debug|release) {
	LIBS += -L$$PWD/../../lib/release/win-x64/ -ltag -lQtAV1 -lUser32
    }
}

# intermediate objects are put in subdirs
CONFIG(debug, debug|release) {
    OBJECTS_DIR = debug/.obj
    MOC_DIR = debug/.moc
    RCC_DIR = debug/.rcc
}
CONFIG(release, debug|release) {
    OBJECTS_DIR = release/.obj
    MOC_DIR = release/.moc
    RCC_DIR = release/.rcc
}
CONFIG += c++11
unix {
    TARGET = miam-core
}
unix:!macx {
    QT += x11extras
    LIBS += -L$$OUT_PWD -L/usr/lib/x86_64-linux-gnu/ -ltag
    LIBS += -lQtAV
    target.path = /usr/lib$$LIB_SUFFIX/
    INSTALLS += target
}
macx {
    #auto clean
    QMAKE_PRE_LINK = rm -rf $$OUT_PWD/../Player/MiamPlayer.app
    QMAKE_RPATHDIR += @executable_path/../Frameworks
    QMAKE_LFLAGS += -F$$PWD/../../lib/osx/QtAV.framework/ -F/System/Library/Frameworks/Carbon.framework/
    LIBS += -L$$PWD/../../lib/osx/ -ltag -framework QtAV -framework Carbon
    QMAKE_SONAME_PREFIX = @executable_path/../Frameworks
    QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.9
}

SOURCES += \
    musiclocationsmodel.cpp \
    musicsearchengine.cpp \
    filehelper.cpp \
    cover.cpp \
    model/genericdao.cpp \
    model/playlistdao.cpp \
    model/sqldatabase.cpp \
    model/trackdao.cpp \
    settings.cpp \
    settingsprivate.cpp \
    library/libraryfilterproxymodel.cpp \
    library/libraryitemmodel.cpp \
    library/miamitemmodel.cpp \
    library/miamsortfilterproxymodel.cpp \
    library/separatoritem.cpp \
    library/trackitem.cpp \
    library/albumitem.cpp \
    library/artistitem.cpp \
    library/yearitem.cpp

HEADERS += \
    miamcore_global.h \
    musiclocationsmodel.h \
    musicsearchengine.h \
    filehelper.h \
    cover.h \
    model/genericdao.h \
    model/playlistdao.h \
    model/sqldatabase.h \
    model/trackdao.h \
    settings.h \
    settingsprivate.h \
    library/libraryfilterproxymodel.h \
    library/libraryitemmodel.h \
    library/miamitemmodel.h \
    library/miamsortfilterproxymodel.h \
    library/separatoritem.h \
    library/trackitem.h \
    library/albumitem.h \
    library/artistitem.h \
    library/yearitem.h

RESOURCES +=

TRANSLATIONS =
