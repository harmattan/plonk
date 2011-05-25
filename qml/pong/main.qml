import Qt 4.7
import com.meego 1.0

Item {
    id: playfield

    width: 400
    height: 400

    function collisionCheck(paddleObj, ballObj, isTop) {
        if (ballObj.x > paddleObj.x &&
            (ballObj.x + ballObj.width) < (paddleObj.x + paddleObj.width)) {
            /* horizontal collision */
            if (isTop) {
                if (ballObj.y < paddleObj.height) {
                    /* vertical collision */
                    ballObj.velocityY *= -1
                    ballObj.y = paddleObj.height
                }
            } else {
                if ((ballObj.y + ballObj.height) > (playfield.height - paddleObj.height)) {
                    ballObj.velocityY *= -1
                    ballObj.y = (playfield.height - paddleObj.height - ballObj.height)
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
        //color: "gray"
        //border.color: "black"
        height: parent.height / 2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        Image {
            id: paddle1
            property int score: 0

            source: "img/paddle_blue.png"
            x: tp1.x
            anchors.bottom: parent.bottom

            Behavior on x {
                NumberAnimation { duration: 100 }
            }
        }

        TouchArea {
            id: touchArea1
            anchors.fill: parent
            touchPoints: [
                TouchPoint { id: tp1 }
            ]
        }
    }

    Item {
        id: topHalf
        //color: "gray"
        //border.color: "black"
        height: parent.height / 2
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        Image {
            id: paddle2
            source: "img/paddle_red.png"
            x: tp2.x
            anchors.top: parent.top
            property int score: 0

            Behavior on x {
                NumberAnimation { duration: 100 }
            }
        }

        TouchArea {
            id: touchArea2
            anchors.fill: parent
            touchPoints: [
                TouchPoint { id: tp2 }
            ]
        }
    }

    Rectangle {
        id: ball
        height: 20
        width: 20
        color: "black"
        y: 10
        x: 10

        property real velocityX: 7
        property real velocityY: 10

        //Behavior on y { PropertyAnimation { duration: 33 } }

        onYChanged: {
            //console.log("y changed:" + ball.y);
            //console.log("Playfield height:" + playfield.height)
            //console.log("Playfield width:" + playfield.width)
            /*var paddles = [paddle1, paddle2]

            for (var i=0; i<paddles.length; i++) {
                //console.log('paddle ' + i + ' -> ' + paddles[i].x)
            }*/

            if (y < 0) {
                velocityY *= -1
                y = 0
                paddle1.score += 1
            } else if (y > playfield.height) {
                velocityY *= -1
                y = playfield.height
                paddle2.score += 1
            }

            if (x < 0) {
                velocityX *= -1
                x = 0
            } else if (x > playfield.width) {
                velocityX *= -1
                x = playfield.width
            }
        }

        Timer {
            running: true
            repeat: true
            interval: 1000 / 60 // 60 FPS

            onTriggered: {
                //console.log('triggered')
                ball.x += ball.velocityX
                ball.y += ball.velocityY

                playfield.collisionCheck(paddle1, ball, false)
                playfield.collisionCheck(paddle2, ball, true)
            }
        }
    }

    onHeightChanged: {
        ball.y = playfield.height
    }



}

