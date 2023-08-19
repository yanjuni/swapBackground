
#include <QColor>
#include <QDebug>
#include <QQmlContext>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "Worker.h"

using namespace std;

int main(int argc, char *argv[])
{

    Worker worker01;
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    app.setOrganizationName("simon");
    app.setOrganizationDomain("simon.cf");
    app.setApplicationName("M k");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.rootContext()->setContextProperty("worker01",&worker01);
    engine.load(url);

    return app.exec();
}
