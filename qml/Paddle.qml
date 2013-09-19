/*
    Mong - A multi-touch pong-like game for MeeGo Tablets
    Copyright (C) 2011 Cornelius Hald, Thomas Perl, Tim Samoff

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0


Item {
    id: paddle
    property bool animationActive: false
    property bool rotated: false
    property color beamColor: "red"
    property color beamHighlightColor: "yellow"
    property int beamX: mapFromItem(container, beamX, 0).x
    property alias beamY: beam.y
    property alias beamWidth: beam.width
    property alias beamHeight: beam.height

    height: 130
    width: 350

    rotation: rotated ? 180 : 0

    Item {
        // This container is there to let the paddle grow from the center. Therefore we
        // place the middle piece exactly onto x=0 and left the left piece grow into negativ x-values
        // and the right piece into positive x-values.
        id: container
        y: 0
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            id: beam
            color: beamColor
            height: 16
            y: 21
            anchors.left: paddleLeft.left
            anchors.leftMargin: 15
            anchors.right: paddleRight.right
            anchors.rightMargin: 15

            SequentialAnimation {
                id: lightUp

                ColorAnimation {
                    target: beam
                    property: 'color'
                    to: beamHighlightColor
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
            fillMode: Image.TileHorizontally
            anchors.left: paddleLeft.horizontalCenter
            anchors.right: paddleRight.horizontalCenter
        }

        PaddleMiddle {
            id: paddleMiddle
            x: 0 - width / 2
            onGaugeMax: paddle.width += 70
            onGaugeMin: paddle.width -= 70
        }

        PaddleLeft {
            id: paddleLeft
            x: -175 - ((paddle.width - 350) / 2)
            Behavior on x {
                SequentialAnimation {
                    ScriptAction { script: paddleLeft.animationActive = true }
                    PropertyAnimation { target: paddle;  duration: 500 } // Dummy, just wait
                    PropertyAnimation { duration: 300; easing.type: Easing.OutQuad }
                    PropertyAnimation { target: paddle;  duration: 500 } // Dummy, just wait
                    ScriptAction { script: paddleLeft.animationActive = false }
                }
            }
        }

        PaddleRight {
            id: paddleRight
            x: (175 - width) + ((paddle.width - 350) / 2)
            Behavior on x {
                SequentialAnimation {
                    ScriptAction { script: paddleRight.animationActive = true }
                    PropertyAnimation { target: paddle;  duration: 500 } // Dummy, just wait
                    PropertyAnimation { duration: 300; easing.type: Easing.OutQuad }
                    PropertyAnimation { target: paddle;  duration: 500 } // Dummy, just wait
                    ScriptAction { script: paddleRight.animationActive = false }
                }
            }
        }
    }

    Behavior on anchors.horizontalCenterOffset {
        NumberAnimation { duration: 50 }
    }

    function glow() {
        lightUp.start()
    }

    function increaseGauge() {
        paddleMiddle.increaseGauge()
    }

    function resetGauge() {
        paddleMiddle.resetGauge()
    }

}
