import Qt 4.7

Image {
    property int score: 0

    source: "img/paddle.png"

    Behavior on x {
        NumberAnimation { duration: 100 }
    }
}
