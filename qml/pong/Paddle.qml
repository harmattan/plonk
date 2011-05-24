import QtQuick 1.0

Rectangle {
    property color color: "green"

    width: 200
    height: 100
    color: "blue"
    x: tp2.x
    anchors.top: parent.top

    Behavior on x {
        NumberAnimation { duration: 100 }
    }
}
