import QtQuick
import TcpClient 1.0
import "../data"
Item {

    signal carSpeedChanged()
    Receive
    {
        id: tcpReceive
        Component.onCompleted: {
             tcpReceive.startServer(1234)
         }
        onMessageReceived:
        {
            CarClusterData.carSpeed = carSpeed;
            CarClusterData.carRMP = carRMP;
            carSpeedChanged()
            console.log(carSpeed)

        }
    }

}
