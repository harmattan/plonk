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
    id: container

    height: 500
    width: 800

    property bool isForegroundApp: true //mongView.active

    /*
    Binding {
        target: swipeControl
        property: 'locked'
        value: playfield.gameOn
    }
    */

    onIsForegroundAppChanged: {
        if (!isForegroundApp) {
            /* Pause gameplay when switching to another task */
            // TODO: This is currently no real pause. It just aborts the current match
            playfield.pauseBall()
            playfield.reset()
            scoreboard.reset()
        }
    }

    Item {
        // Rotate everything into portrait orienation
        height: container.width
        width: container.height
        rotation: 270
        anchors.centerIn: parent

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
            opacity: 1
            anchors.verticalCenter: playfield.verticalCenter
            x: playfield.width

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
                            if (container.isForegroundApp && playfield.gameOn) {
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
            onTriggert: if (container.isForegroundApp) playfield.newBall()
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
                    playfield.gameOn = false
                    countdown.stop()
                }
            }
        }

        Menu {
            id: menu
            scale: mongView.isSymbian()?.7:1
            anchors.centerIn: parent
            opacity: (playfield.gameOn || countdown.opacity == 1) ? 0 : 1
            onPlayClicked: {
                playfield.gameOn = true
                countdown.start()
            }
        }
    }
}
