
import Qt 4.7

Item {
    id: marble
    width: 48
    height: 48

    // FIXME: Need to inject velocity of ball here via properties

    property bool active: true
    property int step: 0

    Timer {
        running: marble.active
        repeat: true
        interval: 33
        triggeredOnStart: true

        onTriggered: {
            var steps = 'abcdefghijkl'
            marble.step += 1
            marble.step %= steps.length
            base.source = 'img/marble/mong_marble_orange_'+steps[marble.step]+'.png'

            // FIXME: Calculate rotation based on direction (vX, vY)
            base.rotation += 1
        }
    }


    Image {
        id: base
    }

    Image {
        id: highlight
        source: 'img/marble/mong_marble_highlight.png'
    }
}
