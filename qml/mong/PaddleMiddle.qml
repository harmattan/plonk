import Qt 4.7

Image {
    id: base
    property int gauge: 0
    source: "img/paddle/paddle_middle.png"

    Image {
        id: gauge
        x: 34
        y: 36
        source: "img/paddle/gauge.png"
        smooth: true

        // TODO: Animation is only for demonstration. Later only animate gauge increase
        // and decrease
        SequentialAnimation {
            loops: Animation.Infinite
            running: true

            RotationAnimation  {
                target: gauge
                property: "rotation"
                from: 0
                to: 45
                duration: 500
            }

            // Pause
            PropertyAnimation {
                duration: 1000
            }

            RotationAnimation  {
                target: gauge
                property: "rotation"
                from: 45
                to: 0
                duration: 500
            }

            // Pause
            PropertyAnimation {
                duration: 1000
            }
        }
    }
}
