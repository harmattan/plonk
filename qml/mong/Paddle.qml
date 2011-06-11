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
    id: paddle
    property bool animationActive: false
    property bool rotated: false
    property color beamColor: "red"
    property color beamHighlightColor: "yellow"

    property alias beamX: beam.x
    property alias beamY: beam.y
    property alias beamWidth: beam.width
    property alias beamHeight: beam.height

    height: 130
    width: 350

    rotation: rotated ? 180 : 0

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
        anchors.left: paddleLeft.horizontalCenter
        anchors.right: paddleRight.horizontalCenter
    }

    PaddleMiddle {
        id: paddleMiddle
        anchors.horizontalCenter: parent.horizontalCenter
    }

    PaddleLeft {
        id: paddleLeft
        anchors.left: parent.left
    }

    PaddleRight {
        id: paddleRight
        anchors.right: parent.right
    }

    Behavior on x {
        NumberAnimation { duration: 50 }
    }

    function glow() {
        lightUp.start()
    }

    function growPaddle() {
        paddle.width = 400
    }

    MouseArea {
        anchors.fill: parent
        onClicked: growPaddle()
    }


}
