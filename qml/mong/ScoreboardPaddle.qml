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
    id: scoreboardPaddle

    property string color
    property bool hidden: false
    height: img.height
    width: img.width

    Image {
        id: img
        source: 'img/scoreboard/score_' + scoreboardPaddle.color + '.png'
        opacity: hidden ? 0 : 1
        Behavior on opacity {
            ParallelAnimation {
                PropertyAnimation { duration: fadeTime }
                ScriptAction { script: emitter.burst(200) }
            }
        }
    }

    ParticleSystem {
        id: particles
    }

    ImageParticle {
        system: particles
        colorVariation: 0.2
        alpha: 0.5
        color: scoreboardPaddle.color
        source: "img/particle.png"
        // No idea why I need the sizeTable, but without I see nothing
        sizeTable: "img/sizetable.png"
    }

    Emitter {
        id: emitter
        system: particles

        // Emitter is a circle with 50x50px size
        height: 50
        width: 50
        shape: EllipseShape {fill: true}

        emitRate: 500

        // Lifespan of the particles
        lifeSpan: 1000
        lifeSpanVariation: 500

        // Only use burst
        enabled: false

        // Size of the particles
        size: 16
        sizeVariation: 8

        // Start velocity and acceleration
        velocity: PointDirection { xVariation: 500; yVariation: 500;}
        acceleration: PointDirection { xVariation: 500; yVariation: 500;}

        anchors.centerIn: parent
    }



}
