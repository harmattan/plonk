import Qt 4.7

Item {
    property int score: 0
    property bool rotated: false
    property alias color: beam.color

    height: base.height
    width: base.width

    rotation: rotated ? 180 : 0

    Item {
        id: container

        Rectangle {
            id: beam
            height: 16
            width: 300
            x: 21
            y: 21
        }

        Image {
            source: "img/paddle/extender.png"
        }

        Image {
            source: "img/paddle/gear_l.png"
        }

        Image {
            source: "img/paddle/gear_r.png"
        }

        Image {
            id: base
            source: "img/paddle/base.png"
        }

        Image {
            source: "img/paddle/gauge.png"
        }
    }

    Behavior on x {
        NumberAnimation { duration: 100 }
    }
}
