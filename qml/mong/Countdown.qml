import QtQuick 1.0

Rectangle {
    id: countDown
    signal triggert
    //rotation: (ball.velocityY < 0)?180:0
    property int defaultSeconds: 3
    property int seconds: defaultSeconds
    height: 200
    width: 200
    color: "lightblue"
    opacity: 0.8
    radius: 20
    anchors.centerIn: parent

    Text {
        text: innerTimer.running ? countDown.seconds : 'GO!'
        font.pixelSize: innerTimer.running ? 150 : 100
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
}
