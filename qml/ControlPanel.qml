import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
Rectangle
{
    width: 400
    height: 60
    color: "transparent"
    RowLayout
    {
        anchors.centerIn: parent
        spacing: 5
        Rectangle
        {
            color: "transparent"
            width: 50
            height: 50
            opacity: 0.05
            Image
            {
                id: leftBlinker
                anchors.fill: parent
                visible: true
                source: "qrc:/icons/left_arrow.png"
                ColorOverlay
                {
                    anchors.fill: parent
                    source: leftBlinker
                    color: "yellow"
                }
                SequentialAnimation
                {
                    running: false
                    loops: Animation.Infinite
                    NumberAnimation { target: leftBlinker; property: "opacity"; from: 1; to: 0; duration: 500 }
                    NumberAnimation { target: leftBlinker; property: "opacity"; from: 0; to: 1; duration: 500 }
                }
            }
        }
        Rectangle
        {
            color: "transparent"
            width: 50
            height: 50
            opacity: 0.1
            Image
            {
                id: handBrake
                anchors.fill: parent
                visible: true
                source: "qrc:/icons/handbrake.png"
                ColorOverlay
                {
                    anchors.fill: parent
                    source: handBrake
                    color: "red"
                }
            }
        }
        Rectangle
        {
            color: "transparent"
            width: 50
            height: 50
            opacity: 0.1
            Image
            {
                id: carOil
                anchors.fill: parent
                visible: true
                source: "qrc:/icons/carOil.png"
                ColorOverlay
                {
                    anchors.fill: parent
                    source: carOil
                    color: "white"
                }
            }
        }
        Rectangle
        {
            color: "transparent"
            width: 50
            height: 50
            opacity: 0.1
            Image
            {
                id: carEngine
                anchors.fill: parent
                visible: true
                source: "qrc:/icons/carEngine.png"
                ColorOverlay
                {
                    anchors.fill: parent
                    source: carEngine
                    color: "white"
                }
            }
        }
        Rectangle
        {
            color: "transparent"
            width: 50
            height: 50
            opacity: 0.1
            Image
            {
                id: abs
                anchors.fill: parent
                visible: true
                source: "qrc:/icons/abs.png"
                ColorOverlay
                {
                    anchors.fill: parent
                    source: abs
                    color: "white"
                }
            }
        }
        Rectangle
        {
            color: "transparent"
            width: 50
            height: 50
            opacity: 0.05
            Image {
                id: rightBlinker
                anchors.fill: parent
                source: "qrc:/icons/right_arrow.png"
                ColorOverlay
                {
                    anchors.fill: parent
                    source: rightBlinker
                    color: "yellow"
                }
                SequentialAnimation
                {
                    running: false
                    loops: Animation.Infinite
                    NumberAnimation { target: rightBlinker; property: "opacity"; from: 1; to: 0; duration: 500 }
                    NumberAnimation { target: rightBlinker; property: "opacity"; from: 0; to: 1; duration: 500 }
                }
            }
        }

    }

}
