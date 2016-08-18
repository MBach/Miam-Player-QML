#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QSettings>

#define COMPANY "MmeMiamMiam"
#define SOFT "MiamPlayerQML"
#define VERSION "0.1"

int main(int argc, char *argv[])
{
    QGuiApplication::setOrganizationName(COMPANY);
    QGuiApplication::setApplicationName(SOFT);
    QGuiApplication::setApplicationVersion(VERSION);
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QSettings appSettings;
    QString style = QQuickStyle::name();

    if (style.isEmpty()) {
        QQuickStyle::setStyle("Material");
        appSettings.setValue("style", "Material");
        appSettings.setValue("theme", "Dark");
    } else {
        QQuickStyle::setStyle(style);
    }

    engine.load(QUrl("qrc:/main.qml"));

    return app.exec();
}
