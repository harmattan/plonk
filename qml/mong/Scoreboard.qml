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
    id: scoreboard

    property bool animate: false
    property int blueCount: 3
    property int redCount: 3
    property int oldBlueCount: 3
    property int oldRedCount: 3
    property bool gameOver: blueCount == 0 || redCount == 0
    property int fadeTime: 150

    width: base.width
    height: base.height

    Image {
        id: shadow
        x: 1
        y: 6
        source: "img/scoreboard/shadow.png"
    }

    Image {
        id: gearLeft
        x: 0
        y: 34
        source: "img/scoreboard/gear.png"
        smooth: true
        RotationAnimation on rotation {
            from: 0
            to: 360
            duration: 3000
            loops: Animation.Infinite
            running: scoreboard.animate
        }
    }

    Image {
        id: gearRight
        x: 357
        y: 34
        source: "img/scoreboard/gear.png"
        smooth: true
        RotationAnimation on rotation {
            from: 0
            to: 360
            duration: 3000
            loops: Animation.Infinite
            running: scoreboard.animate
        }
    }

    Image {
        id: base
        source: "img/scoreboard/base.png"
    }

    ScoreboardPaddle {
        id: scoreBlue1
        x: 305
        y: 58
        color: "blue"
    }

    ScoreboardPaddle {
        id: scoreBlue2
        x: 209
        y: 58
        color: "blue"
    }

    ScoreboardPaddle {
        id: scoreBlue3
        x: 115
        y: 58
        color: "blue"
    }

    ScoreboardPaddle {
        id: scoreRed1
        x: 115
        y: 112
        color: "red"
    }

    ScoreboardPaddle {
        id: scoreRed2
        x: 209
        y: 112
        color: "red"
    }

    ScoreboardPaddle {
        id: scoreRed3
        x: 305
        y: 112
        color: "red"
    }

    function animatePaddleLoss() {
        if (redCount < oldRedCount) {
            if (redCount == 2) scoreRed3.hidden = true
            if (redCount == 1) scoreRed2.hidden = true
            if (redCount == 0) scoreRed1.hidden = true
            oldRedCount = redCount
        }
        if (blueCount < oldBlueCount) {
            if (blueCount == 2) scoreBlue3.hidden = true
            if (blueCount == 1) scoreBlue2.hidden = true
            if (blueCount == 0) scoreBlue1.hidden = true
            oldBlueCount = blueCount
        }
    }

    function decreaseRedCount() {
        scoreboard.redCount--;
        //animation.start();
    }

    function decreaseBlueCount() {
        scoreboard.blueCount--;
        //animation.start();
    }

    function reset() {
        blueCount = 3;
        redCount = 3;
        oldBlueCount = 3;
        oldRedCount = 3;

        scoreBlue1.hidden = false;
        scoreBlue2.hidden = false;
        scoreBlue3.hidden = false;

        scoreRed1.hidden = false;
        scoreRed2.hidden = false;
        scoreRed3.hidden = false;
    }
}
