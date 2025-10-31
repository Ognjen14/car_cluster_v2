import QtQuick
import Qt5Compat.GraphicalEffects
import "../data"
Rectangle {
    id: leftRect
    width: 500
    height: 500
    color: "transparent"

    property int circleSizeOutside: 220
    property int borderWidthCircle: 10

    property real angleTemp: Math.PI / 4

    /******************* White Circle & inside indicator lines **************************/
    Canvas {
        id: canvasTemerature
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.beginPath();
            ctx.arc(parent.width / 2, parent.height / 2, circleSizeOutside,Math.PI / 4, 0, true );
            ctx.lineWidth = borderWidthCircle;
            ctx.strokeStyle = "#262626";
            ctx.stroke();

            var angleStep = (Math.PI / 4 -  Math.PI/2) / 5;
            var radiusLine = circleSizeOutside - borderWidthCircle / 2 + 10;

            for (var i = 0; i <= 5; i++ ) {
                var angle = Math.PI / 4 + angleStep * i;

                var lineStartX = parent.width / 2 + (radiusLine + 6) * Math.cos(angle);
                var lineStartY = parent.height / 2 + (radiusLine + 6) * Math.sin(angle);
                var lineEndX = parent.width / 2 + (radiusLine - 10) * Math.cos(angle);
                var lineEndY = parent.height / 2 + (radiusLine - 10) * Math.sin(angle);

                if( i < 5 ){
                    var angleStep2 = angleStep / 8;
                    for (var j = 0; j < 8; j++) {
                        var grayLineStartX = parent.width / 2 + (radiusLine + 5) * Math.cos(angle + angleStep2 * j);
                        var grayLineStartY = parent.height / 2 + (radiusLine + 5) * Math.sin(angle + angleStep2 * j);
                        var grayLineEndX = parent.width / 2 + (radiusLine - 0) * Math.cos(angle + angleStep2 * j);
                        var grayLineEndY = parent.height / 2 + (radiusLine - 0) * Math.sin(angle + angleStep2 * j);

                        ctx.strokeStyle = "lightblue";
                        if(i == 0)
                        {
                            ctx.strokeStyle = "blue";
                        }

                        if(i == 4)
                        {
                            ctx.strokeStyle = "red";
                        }
                        ctx.beginPath();
                        ctx.lineWidth = 1;
                        ctx.moveTo(grayLineStartX, grayLineStartY);
                        ctx.lineTo(grayLineEndX, grayLineEndY);
                        ctx.stroke();
                    }
                }
                ctx.strokeStyle = "white";

                if(i <=1)
                {
                    ctx.strokeStyle = "blue";
                }

                if(i >= 4)
                {
                    ctx.strokeStyle = "red";
                }
                ctx.beginPath();
                ctx.lineWidth = 3;
                ctx.moveTo(lineStartX, lineStartY);
                ctx.lineTo(lineEndX, lineEndY);
                ctx.stroke();
            }

        }
    }

    Canvas {
        id: canvasFillTemperature
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.beginPath();
            ctx.arc(parent.width / 2, parent.height / 2, circleSizeOutside,  Math.PI / 4, angleTemp, true );
            ctx.lineWidth = borderWidthCircle;
            ctx.strokeStyle = "white";
            ctx.stroke();
        }
    }

    Image
    {
        id: tempImage
        source: "qrc:/icons/motorTemp.png"
        width: 25
        height: 25
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: 110
        anchors.bottomMargin: 75

        ColorOverlay
        {
            id: tempImageColor
            anchors.fill: tempImage
            source: tempImage
            color: "white"
        }
    }


    Timer
    {
        id: temparatureTimer
        interval: 100
        running: true
        repeat: true
        property int direction: -1
        property real maxAngle: 0
        property real minAngle: Math.PI / 4
        onTriggered:
        {

            if( angleTemp + (Math.PI/180) * direction < maxAngle)
            {
                direction *= -1
                temparatureTimer.interval = 3000

            } else if (angleTemp + (Math.PI / 180) * direction > minAngle)
            {
                temparatureTimer.stop()
                direction *= -1
                return;
            }
            angleTemp += (Math.PI / 180) * direction;

            if(angleTemp < maxAngle + Math.PI / 20)
            {
                tempImageColor.color = "red"
            }else
            {
                tempImageColor.color = "white"
            }

            canvasFillTemperature.requestPaint();

        }
    }
}


