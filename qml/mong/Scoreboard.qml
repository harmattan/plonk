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

    signal gameOver

    property int blueCount: 3
    property int redCount: 3
    property int fadeTime: 150
    property alias busy: showScoreboard.running

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
    }

    Image {
        id: gearRight
        x: 357
        y: 34
        source: "img/scoreboard/gear.png"
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

    SequentialAnimation {
        id: showScoreboard

        PropertyAnimation {
            target: scoreboard
            property: "opacity"
            from: 0
            to: 1
            duration: 500
        }

        PropertyAnimation {
            // Just wait some time and do nothing
            duration: 1000
        }

        PropertyAnimation {
            target: scoreboard
            property: "opacity"
            from: 1
            to: 0
            duration: 300
        }
    }

// For testing (remove later)
//    Timer {
//        interval: 1000
//        running: true
//        repeat: true
//        onTriggered: decreaseBlueCount()
//    }

    Timer {
        id: gameOverTimer
        repeat: false
        interval: 2000
        onTriggered: scoreboard.gameOver();
    }

    function decreaseRedCount() {
        showScoreboard.start();
        if (redCount == 3) scoreRed3.hidden = true;
        if (redCount == 2) scoreRed2.hidden = true;
        if (redCount == 1) {
            scoreRed1.hidden = true;
            gameOverTimer.start();

        }
        if (redCount  < 1) return false;
        scoreboard.redCount--;
        return true;
    }

    function decreaseBlueCount() {
        showScoreboard.start();
        if (blueCount == 3) scoreBlue3.hidden = true;
        if (blueCount == 2) scoreBlue2.hidden = true;
        if (blueCount == 1) {
            scoreBlue1.hidden = true;
            gameOverTimer.start();
        }
        if (blueCount  < 1) return false;
        scoreboard.blueCount--;
        return true;
    }

    function reset() {
        blueCount = 3;
        redCount = 3;

        scoreBlue1.hidden = false;
        scoreBlue2.hidden = false;
        scoreBlue3.hidden = false;

        scoreRed1.hidden = false;
        scoreRed2.hidden = false;
        scoreRed3.hidden = false;
    }
}
