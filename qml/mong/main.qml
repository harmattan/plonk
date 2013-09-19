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
import Ubuntu.Components 0.1

MainView {
    id: container
    applicationName: "plonk"

    width: units.gu(90)
    height: units.gu(60)

    /*
    Binding {
        target: swipeControl
        property: 'locked'
        value: playfield.gameOn
    }
    */

    Connections {
        target: mongView
        onWindowInactive: {
            if (playfield.gameOn) {
                playfield.pauseBall()
                pauseOverlay.visible = true
                countdown.pause()
                scoreboard.pause()
            }
        }
    }

    Item {
        anchors.fill: parent

        Playfield {
            id: playfield
            onBallOutPlayer1: {
                scoreboard.decreaseBlueCount()
                scoreboardAnim.start()
                countdown.faceToPlayer1()
            }
            onBallOutPlayer2: {
                scoreboard.decreaseRedCount()
                scoreboardAnim.start()
                countdown.faceToPlayer2()
            }
            anchors.fill: parent
        }

        Scoreboard {
            id: scoreboard
            property bool _prePauseAnimation: false
            opacity: 1
            anchors.verticalCenter: playfield.verticalCenter
            x: playfield.width

            function pause() {
                if (scoreboardAnim.running) {
                    scoreboardAnim.pause()
                }
                if (scoreboard.animate) {
                    _prePauseAnimation = true
                    scoreboard.animate = false
                }
            }

            function resume() {
                if (scoreboardAnim.paused) {
                    scoreboardAnim.resume()
                }
                if (_prePauseAnimation) {
                    scoreboard.animate = true
                }
            }

            // TODO: It would be great if the rotation speed of the gears
            // would match its x movement
            SequentialAnimation {
                id: scoreboardAnim

                ScriptAction { script: scoreboard.animate = true }

                PropertyAnimation {
                    target: scoreboard
                    property: "x"
                    from: playfield.width
                    to: playfield.width / 2 - scoreboard.width / 2
                    duration: 1000
                    easing.type: Easing.OutQuad
                }

                ScriptAction { script: scoreboard.animate = false }

                ScriptAction {
                    script: scoreboard.animatePaddleLoss()
                }

                PropertyAnimation {
                    // do nothing
                    duration: 1500
                }

                ScriptAction { script: scoreboard.animate = true }

                PropertyAnimation {
                    target: scoreboard
                    property: "x"
                    to: -scoreboard.width
                    duration: 1000
                    easing.type: Easing.InQuad
                }

                ScriptAction { script: scoreboard.animate = false }

                ScriptAction {
                    script: {
                        if (scoreboard.gameOver || !playfield.gameOn) {
                            playfield.reset();
                            if (scoreboard.blueCount < scoreboard.redCount) menu.scoreRed++; else menu.scoreBlue++;
                            scoreboard.reset();
                        } else {
                            if (playfield.gameOn) {
                                countdown.start()
                            }
                        }
                    }
                }
            }
        }

        Countdown {
            id: countdown
            opacity: 0
            anchors.centerIn: playfield
            onTriggert: playfield.newBall()
        }

        Image {
            Behavior on opacity { PropertyAnimation { } }
            opacity: playfield.gameOn

            source: "img/menu/btn_power_off.png"
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
            }

            Image {
                source: "img/menu/btn_power_on.png"
                opacity: backToMenuButtonMouse.pressed ? 0 : 1
                anchors.centerIn: parent
            }

            MouseArea {
                id: backToMenuButtonMouse
                anchors.fill: parent
                onClicked: {
                    countdown.stop()
                    scoreboard.reset()
                    playfield.reset()
                }
            }
        }

        Menu {
            id: menu
            anchors.centerIn: parent
            opacity: (playfield.gameOn || countdown.opacity == 1) ? 0 : 1
            onPlayClicked: {
                playfield.gameOn = true
                countdown.start()
            }
        }

        Item {
            id: pauseOverlay
            visible: false
            anchors.fill: parent
            Rectangle {
                color: "black"
                opacity: 0.7
                anchors.fill: parent
            }

            BorderImage {
                id: basePanel
                height: 300
                width: 400
                source: "img/menu/base.png"
                border {
                    left: 100
                    top: 100
                    right: 100
                    bottom: 100
                }
                anchors.centerIn: parent

                Column {
                    spacing: 10
                    anchors.centerIn: parent
                    Image {
                        source: "img/pause.png"

                    }
                    Text {
                        text: "Touch to resume"
                        font.pixelSize: 16
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    pauseOverlay.visible = false
                    playfield.resumeBall();
                    countdown.resume();
                    scoreboard.resume();
                }
            }
        }
    }
}
