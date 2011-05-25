import Qt 4.7
import com.meego 1.0

Item {
    id: playfield

    width: 400
    height: 400

    Item {
        id: bottomHalf
        //color: "gray"
        //border.color: "black"
        height: parent.height / 2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        Rectangle {
            id: paddle1
            width: 200
            height: 100
            color: "red"
            x: tp1.x
            anchors.bottom: parent.bottom

            Behavior on x {
                NumberAnimation { duration: 100 }
            }
        }

        TouchArea {
            id: touchArea1
            anchors.fill: parent
            touchPoints: [
                TouchPoint { id: tp1 }
            ]
        }
    }

    Item {
        id: topHalf
        //color: "gray"
        //border.color: "black"
        height: parent.height / 2
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        Rectangle {
            id: paddle2
            width: 200
            height: 100
            color: "blue"
            x: tp2.x
            anchors.top: parent.top

            Behavior on x {
                NumberAnimation { duration: 100 }
            }
        }

        TouchArea {
            id: touchArea2
            anchors.fill: parent
            touchPoints: [
                TouchPoint { id: tp2 }
            ]
        }
    }

    Rectangle {
        id: ball
        height: 20
        width: 20
        color: "black"
        y: 10
        x: 10

        property real velocityX: 7
        property real velocityY: 10

        //Behavior on y { PropertyAnimation { duration: 33 } }

        onYChanged: {
            //console.log("y changed:" + ball.y);
            console.log("Playfield height:" + playfield.height)
            console.log("Playfield width:" + playfield.width)
            var paddles = [paddle1, paddle2]

            for (var i=0; i<paddles.length; i++) {
                console.log('paddle ' + i + ' -> ' + paddles[i].x)
            }

            if (y < 0) {
                velocityY *= -1
                y = 0
            } else if (y > playfield.height) {
                velocityY *= -1
                y = playfield.height
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
            interval: 30

            onTriggered: {
                console.log('triggered')
                ball.x += ball.velocityX
                ball.y += ball.velocityY
            }
        }
    }

    onHeightChanged: {
        ball.y = playfield.height
    }



}

