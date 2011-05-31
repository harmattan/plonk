/*
    Mong - A multi-touch pong-like game for MeeGo Tablets
    Copyright (C) 2011 Cornelius Hald, Thomas Perl, Tim Samoff

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import Qt 4.7
import com.meego 1.0

Image {
    id: playfield

    /* Set this to true to visualize collision checks */
    property bool collisionDebug: false

    width: 400
    height: 400

    MongSounds {
        id: sounds
    }

    source: "img/background.png"

    function collisionCheck(paddleObj, ballObj, isTop) {
        var paddlePos = playfield.mapFromItem(paddleObj, paddleObj.beamX, paddleObj.beamY)
        var ballPos = playfield.mapFromItem(ballObj, 0, 0)

        if (paddleObj.rotated) {
            /* Fix beam position for rotated paddle */
            paddlePos.x -= paddleObj.beamWidth
            paddlePos.y -= paddleObj.beamHeight
        }

        if (playfield.collisionDebug) {
            var dbgPaddle = dbgPaddle1
            if (isTop) {
                dbgPaddle = dbgPaddle2
            }

            dbgPaddle.x = paddlePos.x
            dbgPaddle.y = paddlePos.y
            dbgPaddle.width = paddleObj.beamWidth
            dbgPaddle.height = paddleObj.beamHeight

            dbgBall.x = ballPos.x
            dbgBall.y = ballPos.y
            dbgBall.width = ballObj.width
            dbgBall.height = ballObj.height
        }

        if ((ballObj.x + (ballObj.width/2)) > paddlePos.x &&
            (ballObj.x + (ballObj.width/2)) < (paddlePos.x + paddleObj.beamWidth)) {
            var paddleCenter = paddlePos.x + (paddleObj.beamWidth / 2)
            var ballCenter = ballObj.x + (ballObj.width / 2)

            /* Direction that can be used for X velocity changes below. */
            var direction = (paddleCenter > ballCenter)?1:-1

            /* Accuracy: If the ball hits the paddle in the middle, it's 1.
                         Otherwise it's decreasing to 0 towards the paddle edges. */
            var accuracy = 2 * (.5 - (Math.abs(paddleCenter-ballCenter) / paddleObj.beamWidth))
            /* horizontal collision */
            if (isTop) {
                if (ballObj.y < (paddlePos.y + paddleObj.beamHeight) &&
                    ballObj.y > (paddlePos.y - ballObj.height)) {
                    /* vertical collision */
                    ballObj.velocityY *= -1
                    ballObj.velocityY *= .5 + (1-accuracy)
                    ballObj.velocityX += 2 * direction * (1-accuracy)
                    ballObj.y = (paddlePos.y + paddleObj.beamHeight)
                    paddleObj.glow()
                    sounds.playHit()
                }
            } else {
                if (ballObj.y > (paddlePos.y - ballObj.height) &&
                    ballObj.y < (paddlePos.y + paddleObj.beamHeight)) {
                    ballObj.velocityY *= -1
                    ballObj.velocityY *= .5 + (1-accuracy)
                    ballObj.velocityX += 2 * direction * (1-accuracy)
                    ballObj.y = (paddlePos.y - ballObj.height)
                    paddleObj.glow()
                    sounds.playHit()
                }
            }
        }

        /* Make sure the ball isn't too slow */
        while (Math.abs(ballObj.velocityY) < 5) {
            ballObj.velocityY *= 1.5
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

        MongTouchArea {
            id: touchArea1
            paddle: paddle1
            anchors.fill: parent
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

        MongTouchArea {
            id: touchArea2
            paddle: paddle2
            anchors.fill: parent
        }
    }

    Ball {
        id: ball
        onActiveChanged: {
            if (!active) {
                sounds.playOut()
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

    Rectangle {
        id: dbgPaddle1
        color: 'red'
        opacity: playfield.collisionDebug?.5:0
        width: 10
        height: 10
    }

    Rectangle {
        id: dbgPaddle2
        color: 'green'
        opacity: playfield.collisionDebug?.5:0
        width: 10
        height: 10
    }

    Rectangle {
        id: dbgBall
        color: 'blue'
        opacity: playfield.collisionDebug?.5:0
        width: 10
        height: 10
    }

    Component.onCompleted: countDown.start()

}

