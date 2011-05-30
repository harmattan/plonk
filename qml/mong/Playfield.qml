import Qt 4.7
import com.meego 1.0

Image {
    id: playfield

    width: 400
    height: 400

    source: "img/background.png"

    function collisionCheck(paddleObj, ballObj, isTop) {
        if (ballObj.x > paddleObj.x &&
            (ballObj.x + ballObj.width) < (paddleObj.x + paddleObj.width)) {
            /* horizontal collision */
            if (isTop) {
                if (ballObj.y < paddleObj.height) {
                    /* vertical collision */
                    ballObj.velocityY *= -1
                    ballObj.y = paddleObj.height
                    paddleObj.glow()
                }
            } else {
                if ((ballObj.y + ballObj.height) > (playfield.height - paddleObj.height)) {
                    ballObj.velocityY *= -1
                    ballObj.y = (playfield.height - paddleObj.height - ballObj.height)
                    paddleObj.glow()
                }
            }
        }
    }

    Text {
        id: score1
        font.pixelSize: 60
        font.bold: true
        color: "blue"
        text: paddle1.score

        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: parent.verticalCenter
        }
    }

    Text {
        id: score2
        font.pixelSize: 60
        font.bold: true
        color: "red"
        text: paddle2.score

        anchors {
            right: parent.right
            rightMargin: 20
            verticalCenter: parent.verticalCenter
        }
    }

    Item {
        id: bottomHalf
        height: parent.height / 2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        Paddle {
            id: paddle1
            beamColor: "blue"
            //x: tp1.x - paddle1.width / 2
            //x: touchArea1.mouseX - paddle1.width / 2
            anchors.bottom: parent.bottom
        }


        // The touch must originate inside the paddle otherwise it's ignored.
        // Because of the offset, it's also possible to grab the paddle at the left or right end.
        // TODO: Maybe do a MongTouchArea, that encapsulates some of that stuff
        TouchArea {
            id: touchArea1
            property int xOffset: 0
            property bool paddleTouched: false
            anchors.fill: parent
            touchPoints: [
                TouchPoint {
                    id: tp1
                    onXChanged: {
                        if (touchArea1.paddleTouched) {
                            paddle1.x = tp1.x - touchArea1.xOffset
                        }
                    }
                }
            ]
            onTouchStart: {
                if (paddle1.x < tp1.x && tp1.x < paddle1.x + paddle1.width) {
                    touchArea1.xOffset = tp1.x - paddle1.x;
                    touchArea1.paddleTouched = true;
                }
            }
            onTouchEnd: {
                touchArea1.paddleTouched = false;
            }
        }

    }

    Item {
        id: topHalf
        height: parent.height / 2
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        Paddle {
            id: paddle2
            beamColor: "red"
            rotated: true
            anchors.top: parent.top
        }

        // The touch must originate inside the paddle otherwise it's ignored.
        // Because of the offset, it's also possible to grab the paddle at the left or right end.
        // TODO: Maybe do a MongTouchArea, that encapsulates some of that stuff
        TouchArea {
            id: touchArea2
            property int xOffset: 0
            property bool paddleTouched: false
            anchors.fill: parent
            touchPoints: [
                TouchPoint {
                    id: tp2
                    onXChanged: {
                        if (touchArea2.paddleTouched) {
                            paddle2.x = tp2.x - touchArea2.xOffset
                        }
                    }
                }
            ]
            onTouchStart: {
                if (paddle2.x < tp2.x && tp2.x < paddle2.x + paddle2.width) {
                    touchArea2.xOffset = tp2.x - paddle2.x;
                    touchArea2.paddleTouched = true;
                }
            }
            onTouchEnd: {
                touchArea2.paddleTouched = false;
            }
        }
    }

    Ball {
        id: ball
        onActiveChanged: {
            if (!active) {
                countDown.start();
            }
        }
    }

    Rectangle {
        id: countDown
        rotation: (ball.velocityY < 0)?180:0
        property int seconds: 3
        height: 200
        width: 200
        color: "lightblue"
        opacity: 0.8
        radius: 20
        anchors.centerIn: parent

        Text {
            text: innerTimer.running?countDown.seconds:'GO!'
            font.pixelSize: innerTimer.running?150:100
            anchors.centerIn: parent
        }

        Timer {
            id: innerTimer
            repeat: true
            interval: 1000
            onTriggered: {
                countDown.seconds--;
                if (countDown.seconds == 0) {
                    running = false;
                    countDown.seconds = 3;
                    countDown.opacity = 0;
                    ball.active = true;
                }
            }
        }

        Behavior on opacity {
            PropertyAnimation { duration: 200 }
        }

        function start() {
            opacity = 1;
            innerTimer.start();
        }
    }

    Component.onCompleted: countDown.start()

}

