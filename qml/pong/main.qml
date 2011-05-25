import QtQuick 1.0

Item {
    id: container

    height: 400
    width: 400

    Playfield {
        height: container.width
        width: container.height
        rotation: 270
        anchors.centerIn: parent
    }

}
