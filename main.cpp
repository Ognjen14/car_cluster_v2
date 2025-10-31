#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "src/TcpClient/tcpclientreceive.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<TCPClientReceive>("TcpClient",1,0,"Receive");
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("car_cluster_v2", "Main");

    return app.exec();
}
