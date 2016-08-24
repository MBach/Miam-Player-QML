#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QSettings>

#define COMPANY "MmeMiamMiam"
#define SOFT "MiamPlayerQML"
#define VERSION "0.1"

#include <musiclocationsmodel.h>

int main(int argc, char *argv[])
{
    QGuiApplication::setOrganizationName(COMPANY);
    QGuiApplication::setApplicationName(SOFT);
    QGuiApplication::setApplicationVersion(VERSION);
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<MusicLocationsModel>("org.miamplayer.qml", 1, 0, "MusicLocationsModel");

    QQmlApplicationEngine engine;

    QSettings appSettings;
    QString style = QQuickStyle::name();

    if (style.isEmpty()) {
        appSettings.setValue("accent", "#3f51b5");
        appSettings.setValue("primary", "#3f51b5");
        appSettings.setValue("background", "black");
        appSettings.setValue("style", "Material");
        appSettings.setValue("theme", "Dark");
        QQuickStyle::setStyle("Material");
    } else {
        QQuickStyle::setStyle(style);
    }

    engine.load(QUrl("qrc:/main.qml"));

    return app.exec();
}
