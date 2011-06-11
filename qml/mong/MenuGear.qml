import Qt 4.7

Image {
    id: gear
    signal resetScore

    source: "img/menu/gear_shadow.png"
    smooth: true

    Image {
        source: "img/menu/gear.png"
        smooth: true
        anchors.centerIn: parent
    }

    PropertyAnimation {
        id: gearAnim
        target: gear
        property: "rotation"
        from: gear.rotation
        to: 0
        duration: 500;
        easing.type: Easing.OutBounce
    }

    onRotationChanged: {
        if (gear.rotation > 65) {
            gearAnim.start()
            gear.resetScore()
        }
    }

    MouseArea {
        property int oldX
        anchors.fill: parent
        onMousePositionChanged: {
            if (mouseX < oldX) {
                gear.rotation++
            }
            oldX = mouseX
        }
        onReleased: {
            gearAnim.start()
        }
    }
}
