import Qt 4.7

Item {
    id: container
    property alias animationActive: animation.running
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
            loops: Animation.Infinite
            from: 0
            to: 360
            duration: 3000
        }
    }

    Image {
        id: baseImg
        source: "img/paddle/paddle_left.png"
    }
}
