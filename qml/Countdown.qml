import QtQuick 2.0

Item {
    id: countDown
    signal triggert
    property int defaultSeconds: 3
    property int seconds: defaultSeconds
    property bool _pause: false
    height: 200
    width: 200
    opacity: 0.8
    rotation: 180
    anchors.centerIn: parent

    function faceToPlayer1() { rotation = 0 }
    function faceToPlayer2() { rotation = 180 }

    Image {
        id: countImg
        source: (innerTimer.running && countDown.seconds > 0) ? "img/countdown/"+countDown.seconds+".png" : "img/countdown/go.png"
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
                countDown.seconds = countDown.defaultSeconds
                countDown.opacity = 0
                countDown.triggert()
            }
        }
    }

    Behavior on opacity {
        PropertyAnimation { duration: 200 }
    }

    function start() {
        seconds = defaultSeconds
        opacity = 1;
        innerTimer.start();
    }

    function stop() {
        opacity = 0;
        innerTimer.stop();
    }

    function pause() {
        if (innerTimer.running) {
            _pause = true
            innerTimer.stop();
        }
    }

    function resume() {
        if (_pause) {
            _pause = false
            start()
        }
    }
}