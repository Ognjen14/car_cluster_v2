import QtQuick
import QtQuick3D
import QtQuick.Controls
import "./data"
import "./qml" as QML

Window {
    width: 1280
    height: 720
    visible: true
    title: qsTr("Car Cluster V2.0")
    color: "black"
             property int myValue: 0

    Image {
        id: backgroundImage
        source: "qrc:/icons/background.jpg"
        anchors.fill: parent
    }
    QML.SpeedDial
    {
        id: speedDial
        anchors.left: parent.left
        anchors.leftMargin: 60
        anchors.verticalCenter: parent.verticalCenter
    }

    QML.RMPDial
    {
        id: rmpDial
        anchors.right: parent.right
        anchors.rightMargin: 60
        anchors.verticalCenter: parent.verticalCenter

    }

    QML.FuelDial
    {
        anchors.left: parent.left
        anchors.leftMargin: 60
        anchors.verticalCenter: parent.verticalCenter
    }

    QML.TemperatureDial
    {
        anchors.right: parent.right
        anchors.rightMargin: 60
        anchors.verticalCenter: parent.verticalCenter
    }

    QML.MainMenu
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 150
    }

   QML.ControlPanel
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 90
    }

    FontLoader
    {
        source: "qrc:/fonts/ProtestGuerrilla-Regular.ttf"
    }


    QML.TCPHandler
    {
        id: tcpHander
        onCarSpeedChanged:
        {
            speedDial.speedKMH =  CarClusterData.carSpeed
            rmpDial.rmpNumber = CarClusterData.carRMP
        }
    }

}
