import Qt 4.7

Image {
    id: base
    signal gaugeMax
    property int value: 0

    source: "img/paddle/paddle_middle.png"

    Image {
        id: gauge
        x: 34
        y: 36
        source: "img/paddle/gauge.png"
        smooth: true
        rotation: 45 - (value * 11)

        Behavior on rotation {
            RotationAnimation { duration: 500; easing.type: Easing.OutElastic }
        }
    }

    Timer {
        id: timer
        interval: 1000
        onTriggered: {
            gaugeMax()
            value = 0
        }
    }

    function increase() {
        if (!timer.running) {
            value++
            if (value >= 4) timer.start()
        }
    }
}
