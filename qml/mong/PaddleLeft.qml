import Qt 4.7

Item {
    id: container
    property bool animationActive: false
    width: baseImg.width
    height: baseImg.height

    Image {
        source: "img/paddle/gear.png"
        anchors {
            left: parent.left
            top: parent.top
            leftMargin: 33
            topMargin: 55
        }

        RotationAnimation on rotation {
            id: animation
            running: animationActive
            loops: Animation.Infinite
            direction: RotationAnimation.Counterclockwise
            from: 360
            to: 0
            duration: 3000
        }
    }

    Image {
        id: baseImg
        source: "img/paddle/paddle_left.png"
    }
}
