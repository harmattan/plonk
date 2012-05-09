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
//import Qt.labs.particles 1.0
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
                //ScriptAction { script: part.burst(100, -1) }
            }
        }
    }

//    Particles {
//        id: part
//        anchors.centerIn: parent
//        width: 1
//        height: 1
//        source: 'img/particle_' + scoreboardPaddle.color + '.png'
//        count: 0 // Don't emit anything by default
//        lifeSpan: 800
//        lifeSpanDeviation: 100
//        angleDeviation: 360
//        velocity: 200
//        velocityDeviation: 190
//    }
}
