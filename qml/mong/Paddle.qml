import Qt 4.7

Item {
    property int score: 0
    property bool rotated: false
    property color beamColor: "red"

    height: base.height
    width: base.width

    rotation: rotated ? 180 : 0

    Item {
        id: container

        Rectangle {
            id: beam
            color: beamColor
            height: 16
            width: 300
            x: 21
            y: 21

            SequentialAnimation {
                id: lightUp

                ColorAnimation {
                    target: beam
                    property: 'color'
                    to: 'yellow'
                    duration: 150
                }

                ColorAnimation {
                    target: beam
                    property: 'color'
                    to: beamColor
                    duration: 250
                }
            }
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

    function glow() {
        lightUp.start()
    }
}
