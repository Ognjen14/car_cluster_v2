#include "tcpclientreceive.h"

TCPClientReceive::TCPClientReceive(QObject *parent)
    : QObject{parent}
{
    connect(&server, &QTcpServer::newConnection, this, &TCPClientReceive::onNewConnection);
}

bool TCPClientReceive::startServer(quint16 port)
{
    if (!server.listen(QHostAddress::Any, port)) {
        return false;
    }
    return true;
}

void TCPClientReceive::stopServer()
{
    server.close();
    for (QTcpSocket *socket : qAsConst(clientSockets)) {
        socket->close();
        socket->deleteLater();
    }
    clientSockets.clear();
}

void TCPClientReceive::onNewConnection()
{
    QTcpSocket *newClient = server.nextPendingConnection();
    if (newClient) {
        clientSockets.append(newClient);
        connect(newClient, &QTcpSocket::readyRead, this, &TCPClientReceive::onReadyRead);
    }
}

void TCPClientReceive::onReadyRead()
{
    for (QTcpSocket *socket : qAsConst(clientSockets)) {
        while (socket->bytesAvailable() > 0) {
            QByteArray data = socket->readAll();
            QDataStream stream(&data, QIODevice::ReadOnly);

            QList<QPair<int, int>> carDataList;

            while (!stream.atEnd()) {
                int carSpeed, carRPM;
                stream >> carSpeed >> carRPM;
                carDataList.append(qMakePair(carSpeed, carRPM));
            }

            for (const auto &carData : carDataList) {
                int speed = carData.first;
                int rpm = carData.second;
                emit messageReceived(speed, rpm);
            }
        }
    }
}

