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
    property bool active: false

    property real velocityX: 10
    property real velocityY: 15

    width: 48
    height: 48

    Marble { active: ball.active }

    onYChanged: {
        if (y < 0) {
            velocityY *= -1
            y = 0
            paddle1.score += 1
            ball.active = false
        } else if (y > playfield.height) {
            velocityY *= -1
            y = playfield.height
            paddle2.score += 1
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

        onTriggered: {
            ball.x += ball.velocityX
            ball.y += ball.velocityY

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
