import QtQuick 1.0
import com.meego 1.0

Item {
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
        color: "yellow"
    }

}

