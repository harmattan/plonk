import QtQuick 1.0

Image {
    property int score: 0

    source: "img/paddle_blue.png"

    Behavior on x {
        NumberAnimation { duration: 100 }
    }
}
