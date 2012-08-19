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

import QtQuick 2.0

Image {
    id: playfield

    signal ballOutPlayer1;
    signal ballOutPlayer2;

    /* Set this to true to visualize collision checks */
    property bool collisionDebug: false

    /* By default the playfield is in 'pause' state */
    property bool gameOn: false

    width: 400
    height: 400

    //MongSounds {
    //    id: sounds
    //}

    source: "img/background.png"

    function collisionCheck(paddleObj, ballObj, oldX, oldY, isTop) {
        var paddlePos = playfield.mapFromItem(paddleObj, paddleObj.beamX, paddleObj.beamY)
        var ballPos = playfield.mapFromItem(ballObj, 0, 0)

        if (paddleObj.rotated) {
            /* Fix beam position for rotated paddle */
            paddlePos.x -= paddleObj.beamWidth
            paddlePos.y -= paddleObj.beamHeight
        }

        var px1 = paddlePos.x
        var px2 = paddlePos.x + paddleObj.beamWidth
        var py = paddlePos.y + paddleObj.beamHeight
        var bx1 = oldX
        var by1 = oldY
        var bx2 = ballPos.x
        var by2 = ballPos.y

        var intersectionPoint = mongView.intersectBallPath(px1, py, px2, py, bx1, by1, bx2, by2)

        /**
         * FIXME: If intersectionPoint.x != -1 and intersectionPoint.y != -1, then
         * a collision has occurred at exactly this point. Move the ball there and
         * reverse its speed, etc..
         **/

        if (playfield.collisionDebug) {
            /* Debug the position of the intersection point (ball / paddle) */
            if (intersectionPoint.x != -1 && intersectionPoint.y != -1) {
                console.log('ISP: ' + intersectionPoint.x + '/' + intersectionPoint.y)
            }

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
                    // Values between 0.9 and 1.2
                    ballObj.velocityY *= (1.2 - 0.3 * (1 - accuracy))
                    ballObj.velocityX += direction * 10 * (1 - accuracy) // 1.2
                    ballObj.y = (paddlePos.y + paddleObj.beamHeight)
                    paddleObj.glow()
                    //sounds.playHit()
                    if (accuracy > 0.8) {
                        paddleObj.increaseGauge()
                    }
                }
            } else {
                if (ballObj.y > (paddlePos.y - ballObj.height) &&
                    ballObj.y < (paddlePos.y + paddleObj.beamHeight)) {
                    ballObj.velocityY *= -1
                    // Values between 0.9 and 1.2
                    ballObj.velocityY *= (1.2 - 0.3 * (1 - accuracy))
                    ballObj.velocityX += direction * 10 * (1 - accuracy)
                    ballObj.y = (paddlePos.y - ballObj.height)
                    paddleObj.glow()
                    //sounds.playHit()
                    if (accuracy > 0.8) {
                        paddleObj.increaseGauge()
                    }
                }
            }
        }

        /* Make sure the ball angle is not too low */
        while (Math.abs(ballObj.velocityX) < 5) {
            ballObj.velocityX *= 1.2
        }

        /* Make sure the ball angle is not too extreme */
        while (Math.abs(ballObj.velocityX) > 20) {
            ballObj.velocityX *= 0.8
        }

        /* Make sure the ball isn't too slow */
        while (Math.abs(ballObj.velocityY) < 10) {
            ballObj.velocityY *= 1.2
        }

        /* Make sure the ball isn't too fast */
        while (Math.abs(ballObj.velocitY) > 20) {
            ballObj.velocityY *= 0.8
        }
    }

    Ball {
        id: ball
        onActiveChanged: {
            if (!active && playfield.gameOn) {
                //sounds.playOut()
            }
        }
        onBallOutPlayer1: playfield.ballOutPlayer1()
        onBallOutPlayer2: playfield.ballOutPlayer2()
    }

    Item {
        id: bottomHalf
        height: parent.height / 2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        Paddle {
            id: paddle1
            anchors.horizontalCenter: parent.horizontalCenter
            beamColor: "red"
            anchors.bottom: parent.bottom
        }

        MongTouchArea {
            id: touchArea1
            paddle: paddle1
            anchors.fill: parent
            enabled: gameOn
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
            anchors.horizontalCenter: parent.horizontalCenter
            beamColor: "blue"
            rotated: true
            anchors.top: parent.top
        }

//        MultiPointTouchArea {
//            id: touchArea2
//            maximumTouchPoints: 1
//            minimumTouchPoints: 1
//            anchors.fill: parent
//            enabled: gameOn
//            touchPoints: [TouchPoint { id: point1 }]
//        }
	
        MongTouchArea {
            id: touchArea2
            paddle: paddle2
            anchors.fill: parent
            enabled: gameOn
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

    function reset() {
        playfield.gameOn = false

        // Put both paddles into the middle
        paddle1.x = (playfield.width / 2) - (paddle1.width / 2)
        paddle2.x = (playfield.width / 2) - (paddle2.width / 2)

        paddle1.resetGauge();
        paddle2.resetGauge();
    }

    function pauseBall() {
        ball.active = false
    }

    function resumeBall() {
        ball.active = true
    }

    function newBall() {
        ball.resetPosition()
        ball.resetSpeed()
        ball.active = true
    }
}

