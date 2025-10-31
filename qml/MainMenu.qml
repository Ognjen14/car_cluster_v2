import QtQuick
import QtQuick.Controls
Rectangle
{
    width: 200
    height: 200
    color: "transparent"
    property int replace: 1
    property int consumption: 0
    StackView
    {
        id: mainStack
        anchors.fill: parent
        initialItem: statistic
        replaceEnter: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 200 }
        }

        replaceExit: Transition {
            NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 200 }
        }
    }

    Component
    {
        id: musicComponenet
        Rectangle
        {

            color: "transparent"

            Image
            {
                anchors.centerIn: parent
                width: 90
                height: 90
                id: songImage
                source: "qrc:/icons/albums/appetite.jpg"

            }
            Text
            {
                anchors
                {
                    top: parent.top
                    topMargin: 150
                    horizontalCenter: parent.horizontalCenter

                }
                id: songArtist
                text: "Guns N' Roses"
                font.family: "protest guerrilla"
                font.bold: true
                font.pixelSize: 17
                color: "white"
            }
            Text
            {
                id: songName
                text: "Sweet Child o' Mine"
                font.family: "protest guerrilla"
                font.bold: true
                font.pixelSize: 17
                color: "white"
                anchors{
                    top: songArtist.bottom
                    topMargin: 5
                    horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    Component
    {
        id: caller
        Rectangle{
            color: "transparent"
            Image
            {
                anchors.centerIn: parent
                width: 90
                height: 90
                id: songImage
                source: "qrc:/icons/caller.png"
            }
            Text
            {
                anchors
                {
                    top: parent.top
                    topMargin: 150
                    horizontalCenter: parent.horizontalCenter
                }

                id: songArtist
                text: "Someone is Calling"
                font.family: "protest guerrilla"
                font.bold: true
                font.pixelSize: 17
                color: "white"
            }
            Text
            {
                id: songName
                text: "Incoming call..."
                font.family: "protest guerrilla"
                font.bold: true
                font.pixelSize: 17
                color: "white"
                anchors{
                    top: songArtist.bottom
                    topMargin: 5
                    horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    Timer
    {
        interval: 5000
        running: true
        repeat: true

        onTriggered:
        {
            if(replace === 1)
            {
                mainStack.replace(musicComponenet)
                replace = 2

            }else if( replace == 2)
            {
                mainStack.replace(caller)
                replace = 3

            }else if(replace == 3)
            {
                consumption = 12
                mainStack.replace(statistic)
                replace = 1
            }
        }
    }

    Component {
        id: statistic
        Rectangle {
            color: "transparent"
            border.width: 1
            border.color: "#31697e"
            radius: 20
            Grid {
                anchors.centerIn: parent
                rows: 3
                columns: 2
                columnSpacing: 10
                rowSpacing: 20
                Image {
                    width: 50
                    height: 50
                    source: "qrc:/icons/avg_speed.png"

                }
                Rectangle{
                    width: 100
                    height: 50
                    color: "transparent"
                    Text {
                        text: "90 kmh"
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "protest guerrilla"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }

                Image {
                    width: 50
                    height: 50
                    source: "qrc:/icons/fuel_cons.png"

                }

                Rectangle{
                    width: 100
                    height: 50
                    color: "transparent"
                    Text {
                        id: consumptionFuel
                        text: consumption + "/100km"
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "protest guerrilla"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }

                Image {
                    width: 50
                    height: 50
                    source: "qrc:/icons/fuel_left.png"

                }
                Rectangle{
                    width: 100
                    height: 50
                    color: "transparent"
                    Text {
                        text: "650 km"
                        font.pixelSize: 20
                        verticalAlignment: Text.AlignVCenter
                        font.family: "protest guerrilla"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }
            }
        }
    }

}
