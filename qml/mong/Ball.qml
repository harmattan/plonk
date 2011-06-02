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

Item {
    id: ball

    signal ballOutPlayer1
    signal ballOutPlayer2

    property bool active: false

    property real velocityX: 10
    property real velocityY: 15

    property int lastMilliseconds: mongView.currentTimeMillis()

    width: 48
    height: 48

    Marble { active: ball.active }

    function checkBorderCollision() {
        if (y < 0) {
            velocityY *= -1
            y = 0
            ball.ballOutPlayer1()
            ball.active = false
        } else if (y > playfield.height) {
            velocityY *= -1
            y = playfield.height
            ball.ballOutPlayer2()
            ball.active = false
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
        id: ticker
        running: ball.active
        repeat: true
        interval: 16 // 1000 / 60 // 60 FPS

        onRunningChanged: {
            if (running) {
                ball.lastMilliseconds = mongView.currentTimeMillis()
            }
        }

        onTriggered: {
            var now = mongView.currentTimeMillis()
            var diff = now - ball.lastMilliseconds
            var xdiff = ball.velocityX * diff / 16
            var ydiff = ball.velocityY * diff / 16

            ball.lastMilliseconds = now
            console.log('step: ' + diff + ', xdiff: ' + xdiff + ', ydiff: ' + ydiff)

            ball.x += xdiff
            ball.y += ydiff
            ball.checkBorderCollision()

            playfield.collisionCheck(paddle1, ball, false)
            playfield.collisionCheck(paddle2, ball, true)
        }
    }

    Binding {
        target: ball
        property: "x"
        value: parent.width / 2
        when: !ball.active
    }

    Binding {
        target: ball
        property: "y"
        value: parent.height / 2
        when: !ball.active
    }

}
