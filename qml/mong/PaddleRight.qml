import QtQuick 2.0

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
            leftMargin: 2
            topMargin: 55
        }

        RotationAnimation on rotation {
            id: animation
            running: animationActive
            loops: Animation.Infinite
            direction: RotationAnimation.Clockwise
            from: 0
            to: 360
            duration: 3000
        }
    }

    Image {
        id: baseImg
        source: "img/paddle/paddle_right.png"
    }
}
