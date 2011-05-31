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

import Qt 4.7

Item {
    property int score: 0
    property bool rotated: false
    property color beamColor: "red"
    property color beamHighlightColor: "yellow"

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
        }

        Image {
            id: leftGear
            source: "img/paddle/gear.png"

            anchors {
                left: parent.left
                top: parent.top
                leftMargin: 33
                topMargin: 55
            }

            // TODO: Only animate when moving/expanding/shrinking
            RotationAnimation on rotation {
                running: true
                loops: Animation.Infinite
                from: 0
                to: 360
                duration: 3000
            }
        }

        Image {
            id: rightGear
            source: "img/paddle/gear.png"

            anchors {
                left: parent.left
                top: parent.top
                leftMargin: 252
                topMargin: 55
            }

            // TODO: Only animate when moving/expanding/shrinking
            RotationAnimation on rotation {
                running: true
                loops: Animation.Infinite
                from: 360
                to: 0
                duration: 3000
            }
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
