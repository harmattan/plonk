import QtQuick 1.0

Image {
    id: ball
    //height: 20
    //width: 20
    source: "img/ball.png"
    y: 10
    x: 10

    property real velocityX: 7
    property real velocityY: 10

    //Behavior on y { PropertyAnimation { duration: 33 } }

    onYChanged: {
        if (y < 0) {
            velocityY *= -1
            y = 0
            paddle1.score += 1
        } else if (y > playfield.height) {
            velocityY *= -1
            y = playfield.height
            paddle2.score += 1
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
        running: true
        repeat: true
        interval: 1000 / 60 // 60 FPS

        onTriggered: {
            //console.log('triggered')
            ball.x += ball.velocityX
            ball.y += ball.velocityY

            playfield.collisionCheck(paddle1, ball, false)
            playfield.collisionCheck(paddle2, ball, true)
        }
    }
}
