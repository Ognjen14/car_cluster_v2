import QtQuick
Rectangle {
    id: leftRect
    width: 500
    height: 500
    color: "transparent"

    property int circleSizeOutside: 220
    property int borderWidthCircle: 10

    property real angleFuel: 3 *Math.PI / 4

    /******************* White Circle & inside indicator lines **************************/
    Canvas {
        id: canvasFuel
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.beginPath();
            ctx.arc(parent.width / 2, parent.height / 2, circleSizeOutside, 3 *Math.PI / 4,  Math.PI);
            ctx.lineWidth = borderWidthCircle;
            ctx.strokeStyle = "#262626";
            ctx.stroke();

            var angleStep = (Math.PI- 3 *Math.PI / 4) / 5;
            var radiusLine = circleSizeOutside - borderWidthCircle / 2 + 10;
        }
    }
    Canvas {
        id: canvasFillFuel
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.beginPath();
            ctx.arc(parent.width / 2, parent.height / 2, circleSizeOutside,  3 *Math.PI / 4, angleFuel );
            ctx.lineWidth = borderWidthCircle;
            ctx.strokeStyle = "white";
            ctx.stroke();
        }
    }

    Canvas
    {
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.beginPath();
            var angleStep = (Math.PI- 3 *Math.PI / 4) / 5;
            var radiusLine = circleSizeOutside - borderWidthCircle / 2 + 10;

            for (var i = 0; i <= 5; i++ ) {
                var angle = 3* Math.PI / 4 + angleStep * i;

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

                        if(i == 0)
                        {
                            ctx.strokeStyle = "red";
                        }else if(i == 4)
                        {
                              ctx.strokeStyle = "blue";
                        }
                        else{
                            ctx.strokeStyle = "lightblue";
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
                    ctx.strokeStyle = "red";
                }
                else if(i >= 4)
                {
                    ctx.strokeStyle = "blue";
                }else
                {
                     ctx.strokeStyle = "lightblue";
                }

                ctx.beginPath();
                ctx.lineWidth = 3;
                ctx.moveTo(lineStartX, lineStartY);
                ctx.lineTo(lineEndX, lineEndY);
                ctx.stroke();
            }
        }
    }



    Image {
        id: fuelImage
        source: "qrc:/icons/fuelIconOff.png"
        width: 20
        height: 20
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 110
        anchors.bottomMargin: 75
    }

    Timer
    {
        id: fuelTimer
        interval: 100
        running: true
        repeat: true
        property int direction: 1
        property real maxAngle: Math.PI
        property real minAngle:3 * Math.PI / 4
        onTriggered:
        {

            if( angleFuel + (Math.PI/180) * direction > maxAngle)
            {
                direction *= -1
                fuelTimer.interval = 3000

            } else if (angleFuel + (Math.PI / 180) * direction < minAngle)
            {
                direction *= -1
                fuelTimer.stop()
                return;
            }
            angleFuel += (Math.PI / 180) * direction;

            if(angleFuel < minAngle + Math.PI/ 20)
            {
                fuelImage.source =  "qrc:/icons/fuelIconOn.png"
            }else
            {
                fuelImage.source =  "qrc:/icons/fuelIconOff.png"
            }

            canvasFillFuel.requestPaint();

        }
    }
}


