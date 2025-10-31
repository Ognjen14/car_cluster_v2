/************************* RMP DIAL **************************************/

import QtQuick
Rectangle {
    id: leftRect
    width: 500
    height: 500
    color: "transparent"

    property int circleSizeOutside: 200
    property int borderWidthCircle: 5

    property int circleSizeInside: 130
    property int borderWidthCirclInside: 50

     property int rmpNumber: 0
       property bool is2nd: false

    property real angleStepFill: (Math.PI / 4-  3*Math.PI/2) / 130;
    property real angleRMP: Math.PI / 4
    property int fillCount: 0
    property int angleRMPdActual

    /******************************* White Circle & inside indicator lines(tiny ones) *********************/
    Canvas {
        id: canvasOutsideCircle
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.beginPath();
            ctx.arc(parent.width / 2, parent.height / 2, circleSizeOutside, Math.PI / 4, Math.PI , true);
            ctx.lineWidth = borderWidthCircle;

            ctx.strokeStyle = "white";
            ctx.stroke();
            var angleStep = (Math.PI / 4  - 3*Math.PI/2) / 8;
            var lineStartPosition = circleSizeOutside - borderWidthCircle / 2 + 8;

            for (var i = 0; i <= 8; i += 1) {
                var angle = Math.PI / 4 + angleStep * i;

                var lineStartX = parent.width / 2 + (lineStartPosition - 10) * Math.cos(angle);
                var lineStartY = parent.height / 2 + (lineStartPosition - 10) * Math.sin(angle);
                var lineEndX = parent.width / 2 + (lineStartPosition - 15) * Math.cos(angle);
                var lineEndY = parent.height / 2 + (lineStartPosition - 15) * Math.sin(angle);

                if( i < 8 ){
                    var angleStep2 = angleStep  / 10;
                    for (var j = 0; j < 10; j++) {
                        var grayLineStartX = parent.width / 2 + (lineStartPosition - 10) * Math.cos(angle + angleStep2 * j);
                        var grayLineStartY = parent.height / 2 + (lineStartPosition - 10) * Math.sin(angle + angleStep2 * j);
                        var grayLineEndX = parent.width / 2 + (lineStartPosition - 12) * Math.cos(angle + angleStep2 * j);
                        var grayLineEndY = parent.height / 2 + (lineStartPosition - 12) * Math.sin(angle + angleStep2 * j);


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


    /******************************* Background indicator Line *******************************************/
    Canvas {
        id: canvasIndicatorBackground
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.beginPath();
            var angleStep = (Math.PI / 4  - 3*Math.PI/2) / 130;
            var lineStartPosition = circleSizeOutside - borderWidthCircle / 2 + 8;

            for (var i = 0; i <= 130; i++) {
                var angle = Math.PI / 4 + angleStep * i;


                var lineStartX = parent.width / 2 + (lineStartPosition - 17) * Math.cos(angle );
                var lineStartY = parent.height / 2 + (lineStartPosition - 17) * Math.sin(angle );
                var lineEndX = parent.width / 2 + (lineStartPosition - 44) * Math.cos(angle );
                var lineEndY = parent.height / 2 + (lineStartPosition - 44) * Math.sin(angle );


                ctx.strokeStyle = "#262626";


                ctx.beginPath();
                ctx.lineWidth = 3;
                ctx.lineCap = "round";
                ctx.moveTo(lineStartX, lineStartY);
                ctx.lineTo(lineEndX, lineEndY);
                ctx.stroke();

            }
        }
    }


    /******************************* White Indicator Line *************************************************/
    Canvas {
        id: canvasIndicatorFill
        anchors.fill: parent
        property bool first: true
        property int direction: 1
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.beginPath();
            var lineStartPosition = circleSizeOutside - borderWidthCircle / 2 + 8;

                var angle = Math.PI / 4 + angleStepFill * fillCount;
                var lineStartX = parent.width / 2 + (lineStartPosition - 17) * Math.cos(angle);
                var lineStartY = parent.height / 2 + (lineStartPosition - 17) * Math.sin(angle );
                var lineEndX = parent.width / 2 + (lineStartPosition - 44) * Math.cos(angle );
                var lineEndY = parent.height / 2 + (lineStartPosition - 44) * Math.sin(angle );

                ctx.strokeStyle = "red";
                ctx.beginPath();
                ctx.lineWidth = 3;
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


    /******************************* Inside Circle ********************************************************/
    Canvas {
        id: canvasInsideCircle
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.beginPath();
             ctx.arc(parent.width / 2, parent.height / 2, circleSizeInside, Math.PI / 4, Math.PI , true);
            ctx.lineWidth = borderWidthCirclInside;
            ctx.strokeStyle = "#31697e";
            ctx.stroke();


            var angleStep = (Math.PI / 4  - 3*Math.PI/2) / 8;
            var lineStartPosition = circleSizeInside - borderWidthCirclInside / 2 + 8;

            for (var i = 0; i <= 8; i += 1) {
                var angle = Math.PI / 4 + angleStep * i;
                var x = parent.width / 2 + lineStartPosition * Math.cos(angle);
                var y = parent.height / 2 + lineStartPosition * Math.sin(angle);

                var lineStartX = parent.width / 2 + (lineStartPosition + 42) * Math.cos(angle);
                var lineStartY = parent.height / 2 + (lineStartPosition + 42) * Math.sin(angle);
                var lineEndX = parent.width / 2 + (lineStartPosition - 8) * Math.cos(angle);
                var lineEndY = parent.height / 2 + (lineStartPosition - 8) * Math.sin(angle);

                ctx.strokeStyle = "black";
                ctx.beginPath();
                ctx.lineWidth = 1;
                ctx.moveTo(lineStartX, lineStartY);
                ctx.lineTo(lineEndX, lineEndY);
                ctx.stroke();

            }
        }
    }


    /******************************* Text Car RMP  ********************************************************/
    Text
    {
        id: textSpeed
        anchors.centerIn: parent
        text: rmpNumber
        color: "white"
        font.pixelSize: 50
        font.family: "protest guerrilla"
    }
    /******************************* Text Car RMP  ********************************************************/
    Text
    {
        text: " rmp"
        anchors.left: textSpeed.right
        anchors.top: parent.top
        anchors.topMargin: 215
        font.family: "protest guerrilla"
        font.pixelSize: 15
        color: "white"
    }

    /******************************* Text Timer for Simulation of RML *************************************/
    Timer
    {
        id: timer
        interval: 50
        running: true
        repeat: true
        property int direction: 1
        property real maxAngle: 3*Math.PI/2 + 36 * Math.PI / 180
        property real minAngle: Math.PI / 4
        property bool is2nd: false
        onTriggered:
        {

            if( angleRMP + (Math.PI/180) * direction > maxAngle)
            {
                timer.interval = 100
                direction *= -1
            } else if (angleRMP  < minAngle)
            {

                direction *= -1
                timer.stop()
                return;

            }
            angleRMP += (Math.PI / 180) * direction;
            var angleRMPdActual = angleRMP - minAngle;
            var speedInDegrees = angleRMPdActual * 180 / Math.PI * 30.76923;
            var roundedSpeed = Math.round(speedInDegrees);

            if(roundedSpeed <= 50)
            {
                roundedSpeed = 0
            }
            textSpeed.text = roundedSpeed;

            if(is2nd)
            {
                canvasIndicatorFill.requestPaint();
                is2nd=false
            }else
            {
                is2nd = true
            }
        }
    }

    onRmpNumberChanged:
    {
        angleRMP = rmpNumber / 30.76923 *(Math.PI / 180)
        console.log(angleRMP)
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
