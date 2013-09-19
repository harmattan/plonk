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
import QtQuick.Particles 2.0

Item {
    id: ball

    signal ballOutPlayer1
    signal ballOutPlayer2

    property bool active: false

    property real velocityX: 0
    property real velocityY: 0

    property real defaultVelocityX: 12
    property real defaultVelocityY: 15

    // Use var here - int is too small
    property var lastMilliseconds: mongView.currentTimeMillis()

    width: 48
    height: 48
    opacity: active ? 1 : 0

    Marble { }

    function checkBorderCollision() {
        if (y < 0) {
            velocityY *= -1
            y = 0
            ball.ballOutPlayer1()
            resetSpeed()
            ball.active = false
        } else if (y > playfield.height) {
            velocityY *= -1
            y = playfield.height
            ball.ballOutPlayer2()
            resetSpeed()
            ball.active = false
        }

        if (x < 0) {
            velocityX *= -1
            x = 0
        } else if (x > playfield.width - ball.width) {
            velocityX *= -1
            x = playfield.width - ball.width
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
            var oldX = ball.x
            var oldY = ball.y
            var now = mongView.currentTimeMillis()
            var diff = now - ball.lastMilliseconds

            var xdiff = ball.velocityX * diff / 16
            var ydiff = ball.velocityY * diff / 16

            ball.lastMilliseconds = now
            ball.x += xdiff
            ball.y += ydiff
            ball.checkBorderCollision()

            playfield.collisionCheck(paddle1, ball, oldX, oldY, false)
            playfield.collisionCheck(paddle2, ball, oldX, oldY, true)
        }
    }

    // Set ball in the middle of the playing field
    function resetPosition() {
        x = parent.width / 2
        y = parent.height / 2
    }

    // Resets the ball to default values and adds
    // a random effect to make it less predictable
    function resetSpeed() {
        // Value between +/- defaultVelocityX -> Defines the angle
        var rand = Math.floor(Math.random() * defaultVelocityX + 1)

        // Randomly left or right -> Defines the direction
        velocityX = rand * (Math.random() > 0.5 ? 1 : -1)

        // Rest to default velocity, but keep the direction
        velocityY = velocityY > 0 ? defaultVelocityY : defaultVelocityY * -1
    }

//    ParticleSystem {
//        id: ballParticles
//    }

    ImageParticle {
        system: ballParticles
        colorVariation: 0.5
        alpha: 0.5
        color: "white"
        source: "img/particle.png"
        // No idea why I need the sizeTable, but without I see nothing
        sizeTable: "img/sizetable.png"
    }

    Emitter {
        id: emitter
        system: ballParticles

        // Emitter is a circle with 50x50px size
        height: 10
        width: 10
        shape: EllipseShape {fill: true}

        emitRate: 200

        // Lifespan of the particles
        lifeSpan: 500
        lifeSpanVariation: 500

        enabled: active

        // Size of the particles
        size: 16
        sizeVariation: 8

        velocityFromMovement: 10

        // Start velocity and acceleration
        velocity: PointDirection { xVariation: 40; yVariation: 40;}
        acceleration: PointDirection { xVariation: 40; yVariation: 40;}

        anchors.centerIn: parent
    }

}
