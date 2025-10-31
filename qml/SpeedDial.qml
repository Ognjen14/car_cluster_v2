import QtQuick
import "../data"
Rectangle {
    id: leftRect
    width: 500
    height: 500
    color: "transparent"

    property int circleSizeOutside: 200
    property int borderWidthCircle: 5
    property string colorTest: "white"
    property string colorTest2: "white"

    property int circleSizeInside: 140
    property int borderWidthCirclInside: 50

    property int speedKMH: 0
    property bool is2nd: false


    property real angleStepFill: (2 * Math.PI - 3*Math.PI / 4) / 130;
    property real angleSpeed: 3 *Math.PI / 4
    property int fillCount: 0
    property  int angleSpeedActual

    /******************* White Circle & inside indicator lines **************************/
    Canvas {
        id: canvasOutside
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.beginPath();
            ctx.arc(parent.width / 2, parent.height / 2, circleSizeOutside, 3 *Math.PI / 4, 2*Math.PI);
            ctx.lineWidth = borderWidthCircle;
            ctx.strokeStyle = "white";
            ctx.stroke();


            var angleStep = (2*Math.PI- 3 *Math.PI / 4) / 260;
            var radiusLine = circleSizeOutside - borderWidthCircle / 2 + 8;

            for (var i = 0; i <= 260; i += 20) {
                var angle = 3* Math.PI / 4 + angleStep * i;

                var lineStartX = parent.width / 2 + (radiusLine - 10) * Math.cos(angle);
                var lineStartY = parent.height / 2 + (radiusLine - 10) * Math.sin(angle);
                var lineEndX = parent.width / 2 + (radiusLine - 15) * Math.cos(angle);
                var lineEndY = parent.height / 2 + (radiusLine - 15) * Math.sin(angle);

                if( i < 260 ){
                    var angleStep2 = angleStep * 2;
                    for (var j = 0; j < 10; j++) {
                        var grayLineStartX = parent.width / 2 + (radiusLine - 10) * Math.cos(angle + angleStep2 * j);
                        var grayLineStartY = parent.height / 2 + (radiusLine - 10) * Math.sin(angle + angleStep2 * j);
                        var grayLineEndX = parent.width / 2 + (radiusLine - 12) * Math.cos(angle + angleStep2 * j);
                        var grayLineEndY = parent.height / 2 + (radiusLine - 12) * Math.sin(angle + angleStep2 * j);


                        ctx.strokeStyle = "lightblue";
                        ctx.beginPath();
                        ctx.lineWidth = 1;
                        ctx.moveTo(grayLineStartX, grayLineStartY);
                        ctx.lineTo(grayLineEndX, grayLineEndY);
                        ctx.stroke();
                    }
                }
                ctx.strokeStyle = "#e3900b";
                ctx.beginPath();
                ctx.lineWidth = 5;
                ctx.moveTo(lineStartX, lineStartY);
                ctx.lineTo(lineEndX, lineEndY);
                ctx.stroke();

            }
        }
    }

    Canvas {
        id: canvasIndicatorBackground
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.beginPath();
            var angleStep = (2*Math.PI- 3 *Math.PI / 4) / 130;
            var radiusLine = circleSizeOutside - borderWidthCircle / 2 + 8;

            for (var i = 0; i <= 130; i++) {
                var angle = 3* Math.PI / 4 + angleStep * i;


                var lineStartX = parent.width / 2 + (radiusLine - 17) * Math.cos(angle );
                var lineStartY = parent.height / 2 + (radiusLine - 17) * Math.sin(angle );
                var lineEndX = parent.width / 2 + (radiusLine - 34) * Math.cos(angle );
                var lineEndY = parent.height / 2 + (radiusLine - 34) * Math.sin(angle );

                ctx.strokeStyle = "#262626";
                ctx.beginPath();
                ctx.lineWidth = 2;
                ctx.lineCap = "round";
                ctx.moveTo(lineStartX, lineStartY);
                ctx.lineTo(lineEndX, lineEndY);
                ctx.stroke();

            }
        }
    }

    Canvas {
        id: inside
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.beginPath();
            ctx.arc(parent.width / 2, parent.height / 2, circleSizeInside, 3 *Math.PI / 4, 2*Math.PI);
            ctx.lineWidth = borderWidthCirclInside;
            ctx.strokeStyle = "#31697e";
            ctx.stroke();

            var angleStep = (2*Math.PI- 3 *Math.PI / 4) / 260;
            var radiusLine = circleSizeInside - borderWidthCirclInside / 2 + 8;

            for (var i = 0; i <= 260; i += 20) {
                var angle = 3* Math.PI / 4 + angleStep * i;
                var x = parent.width / 2 + radiusLine * Math.cos(angle);
                var y = parent.height / 2 + radiusLine * Math.sin(angle);

                var lineStartX = parent.width / 2 + (radiusLine + 42) * Math.cos(angle);
                var lineStartY = parent.height / 2 + (radiusLine + 42) * Math.sin(angle);
                var lineEndX = parent.width / 2 + (radiusLine - 8) * Math.cos(angle);
                var lineEndY = parent.height / 2 + (radiusLine - 8) * Math.sin(angle);

                ctx.strokeStyle = "black";
                ctx.beginPath();
                ctx.lineWidth = 1;
                ctx.moveTo(lineStartX, lineStartY);
                ctx.lineTo(lineEndX, lineEndY);
                ctx.stroke();

            }
        }
    }
    Canvas {
        id: canvasIndicatorFill
        anchors.fill: parent
        property bool first: true
        property int direction: 1
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.beginPath();
            var radiusLine = circleSizeOutside - borderWidthCircle / 2 + 8;

            var angle = 3* Math.PI / 4 + angleStepFill * fillCount;
            var lineStartX = parent.width / 2 + (radiusLine - 17) * Math.cos(angle);
            var lineStartY = parent.height / 2 + (radiusLine - 17) * Math.sin(angle );
            var lineEndX = parent.width / 2 + (radiusLine - 34) * Math.cos(angle );
            var lineEndY = parent.height / 2 + (radiusLine - 34) * Math.sin(angle );

            ctx.strokeStyle = "white";
            ctx.beginPath();
            ctx.lineWidth = 2;
            ctx.lineCap = "round";
            ctx.moveTo(lineStartX, lineStartY);
            ctx.lineTo(lineEndX, lineEndY);
            ctx.stroke();
            if(fillCount >= 130)
            {
                direction = -1
            }else if(fillCount <= 0)
            {
                direction = 1
            }
            fillCount += 1 * direction
        }
    }



    Text
    {
        id: textSpeed
        anchors.centerIn: parent
        text: speedKMH
        color: "white"
        font.pixelSize: 75
        font.family: "protest guerrilla"
    }

    Text
    {
        text: " km/h"
        anchors.left: textSpeed.right
        anchors.top: parent.top
        anchors.topMargin: 215
        font.family: "protest guerrilla"
        font.pixelSize: 15
        color: "white"
    }

    Timer
    {
        id: timer
        interval: 10
        running: true
        repeat: true
        property int direction: 1
        property real maxAngle: 2 * Math.PI + 36 * Math.PI / 180
        property real minAngle: 3 * Math.PI / 4
        property bool is2nd: false
        property int count: 0
        onTriggered:
        {

            if( angleSpeed + (Math.PI/180) * direction > maxAngle)
            {
                direction *= -1
                timer.interval= 100
            } else if (angleSpeed + (Math.PI / 180) * direction < minAngle)
            {
                direction *= -1
                timer.stop()
            }

            angleSpeed += (0.5*Math.PI / 180) * direction;
            var angleSpeedActual = angleSpeed - minAngle;
            var speedInDegrees = angleSpeedActual * 180 / Math.PI;
            var roundedSpeed = Math.round(speedInDegrees);
            if(roundedSpeed <= 1)
            {
                roundedSpeed = 0
            }
            textSpeed.text = roundedSpeed;


            if(count == 3)
            {
                canvasIndicatorFill.requestPaint();
                count = 0
            }else
            {
                count++
            }
        }
    }
    onSpeedKMHChanged:
    {
        angleSpeed = speedKMH * Math.PI / 180
        if(is2nd)
        {
             canvasIndicatorFill.requestPaint();
             is2nd = false
        }else
        {
            is2nd = true
        }

    }

}


