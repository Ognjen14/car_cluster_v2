#pragma once
#include <QObject>
#include <QTcpServer>
#include <QTcpSocket>
class TCPClientReceive : public QObject
{
    Q_OBJECT
public:
    explicit TCPClientReceive(QObject *parent = nullptr);

    /**
     * @brief Starts the TCP server on the specified port.
     * @param port The port number on which the server should listen.
     * @return True if the server starts successfully; otherwise, false.
     *
     * This function starts the TCP server to listen for incoming connections
     * on the specified port. It returns true if the server starts successfully;
     * otherwise, it returns false.
     */
    Q_INVOKABLE bool startServer(quint16 port);
    /**
     * @brief Stops the TCP server and closes all client connections.
     *
     * This function stops the TCP server and closes all client connections
     * associated with it.
     */
    Q_INVOKABLE void stopServer();

signals:

    void messageReceived(int carSpeed ,int carRMP);

private slots:
    /**
     * @brief Slot called when a new client connection is established.
     */
    void onNewConnection();

    /**
     * @brief Slot for processing incoming data from connected clients.
     *
     * Reads and processes incoming data from client sockets. Extracts values
     * for cooler and detector currents/voltages. Emits 'messageReceived' signal
     * with parsed data. Logs received values for debugging.
     */
    void onReadyRead();

private:
    QTcpServer server;                ///< The TCP server object.
    QList<QTcpSocket*> clientSockets; ///< List of connected client sockets.

};

