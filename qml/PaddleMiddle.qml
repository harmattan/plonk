import QtQuick 2.0

Image {
    id: base

    signal gaugeMax
    signal gaugeMin

    property int value: 0
    property int decreaseTime: 1000 // Time in ms it take to decrease gauge by 1 unit
    property bool gaugeDecreases: false

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
        repeat: true
        interval: decreaseTime
        running: gaugeDecreases
        onTriggered: {
            value--
            if (base.value <= 0) {
                gaugeDecreases = false
                gaugeMin()
            }
        }
    }

    function increaseGauge() {
        if (!gaugeDecreases) {
            value++
            if (value >= 4) {
                gaugeMax()
                gaugeDecreases = true
                timer.start()
            }
        }
    }

    function resetGauge() {
        value = 0
    }

}
