import QtQuick 1.0

Item {
    id: scoreboard

    signal redDied()
    signal blueDied()

    property int blueCount: 3
    property int redCount: 3
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
        id: base
        source: "img/scoreboard/base.png"
    }

    Image {
        id: scoreBlue1
        x: 305
        y: 58
        source: "img/scoreboard/score_blue.png"
        Behavior on opacity { PropertyAnimation { duration: fadeTime } }
    }

    Image {
        id: scoreBlue2
        x: 209
        y: 58
        source: "img/scoreboard/score_blue.png"
        Behavior on opacity { PropertyAnimation { duration: fadeTime } }
    }

    Image {
        id: scoreBlue3
        x: 115
        y: 58
        source: "img/scoreboard/score_blue.png"
        Behavior on opacity { PropertyAnimation { duration: fadeTime } }
    }

    Image {
        id: scoreRed1
        x: 115
        y: 112
        source: "img/scoreboard/score_red.png"
        Behavior on opacity { PropertyAnimation { duration: fadeTime } }
    }

    Image {
        id: scoreRed2
        x: 209
        y: 112
        source: "img/scoreboard/score_red.png"
        Behavior on opacity { PropertyAnimation { duration: fadeTime } }
    }

    Image {
        id: scoreRed3
        x: 305
        y: 112
        source: "img/scoreboard/score_red.png"
        Behavior on opacity { PropertyAnimation { duration: fadeTime } }
    }

    function decreaseRedCount() {
        if (redCount == 3) scoreRed3.opacity = 0;
        if (redCount == 2) scoreRed2.opacity = 0;
        if (redCount == 1) scoreRed1.opacity = 0;
        if (redCount == 0) redDied();
        if (redCount  < 0) return false;
        redCount--;
        return true;
    }

    function decreaseBlueCount() {
        if (blueCount == 3) scoreBlue3.opacity = 0;
        if (blueCount == 2) scoreBlue2.opacity = 0;
        if (blueCount == 1) scoreBlue1.opacity = 0;
        if (blueCount == 0) blueDied();
        if (blueCount  < 0) return false;
        blueCount--;
        return true;
    }

    function reset() {
        scoreBlue1.opacity = 1;
        scoreBlue2.opacity = 1;
        scoreBlue3.opacity = 1;

        scoreRed1.opacity = 1;
        scoreRed2.opacity = 1;
        scoreRed3.opacity = 1;
    }
}
