import Qt 4.7

Image {
    id: ball
    property bool active: false

    property real velocityX: 10
    property real velocityY: 15

    source: "img/ball.png"

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
