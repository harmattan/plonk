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
    id: menu
    signal playClicked
    signal aboutClicked

    Item {
        id: gear
        height: gearImg.height
        width: gearImg.width
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: gearImg
            source: "img/menu/gear_shadow.png"
            smooth: true
            anchors.centerIn: parent

            Image {
                source: "img/menu/gear.png"
                smooth: true
                anchors.centerIn: parent
            }

            PropertyAnimation {
                id: gearAnim
                target: gearImg
                property: "rotation"
                from: gearImg.rotation
                to: 0
                duration: 500;
                easing.type: Easing.OutBounce
            }

            onRotationChanged: {
                if (gearImg.rotation > 65) {
                    gearAnim.start()
                }
            }
        }

        MouseArea {
            property int oldX
            anchors.fill: parent
            onMousePositionChanged: {
                if (mouseX < oldX) {
                    gearImg.rotation++
                }
                oldX = mouseX
            }
            onReleased: {
                gearAnim.start()
            }
        }
    }

    BorderImage {
        id: background

        source: "img/menu/base.png"
        anchors.fill: parent
        anchors.bottomMargin: 115

        border {
            left: 100
            top: 100
            right: 100
            bottom: 100
        }

        Item {
            id: mainMenuContainer
            anchors.fill: parent

            Behavior on opacity { PropertyAnimation { } }

            Image {
                id: imageTitle
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 40
                source: "img/menu/title.png"
                transformOrigin: Item.Top
                Behavior on scale { PropertyAnimation { } }
            }

            MenuButton {
                id: playButton
                anchors.horizontalCenter: parent.horizontalCenter
                y: 181
                imageOff: "img/menu/btn_play_off.png"
                imageOn:  "img/menu/btn_play_on.png"
                onClicked: menu.playClicked()
            }

            MenuButton {
                id: aboutButton
                anchors.horizontalCenter: parent.horizontalCenter
                y: 281
                imageOff: "img/menu/btn_about_off.png"
                imageOn:  "img/menu/btn_about_on.png"
                onClicked: menu.aboutClicked()
            }
        }

        MouseArea {
            id: aboutMenuContainer
            anchors.fill: parent
            Behavior on opacity { PropertyAnimation { } }

            Image {
                id: imageTitleAbout
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 40
                source: "img/menu/title_about.png"
                transformOrigin: Item.Top
                Behavior on scale { PropertyAnimation { } }
            }

            Item {
                anchors {
                    top: imageTitleAbout.bottom
                    left: parent.left
                    bottom: parent.bottom
                    right: parent.right
                    leftMargin: 50
                    topMargin: 20
                    rightMargin: 50
                    bottomMargin: 50
                }

                /* TODO: Scroll this by setting the y offset of the Text
                   below as with the movie credits (when we got enough text) */

                clip: true

                Text {
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                    text: '<center><h1>Version 1.0</h1><h2>"Revenge of the Killer Paddle"</h2><p><strong>Programming</strong><br>Cornelius Hald<br>Thomas Perl</p><p><strong>Graphics</strong><br>Tim Samoff</p><p><strong>Sound Effects</strong><br>Erik Stein</p><br><p>Initially developed at the MeeGo Conference 2011 in San Francisco.<br>Sound effects from the air hockey tables at the Hacker Lounge.</p></center>'
                }
            }

            onClicked: menu.state = 'mainMenu'
        }
    }

    onAboutClicked: {
        state = 'aboutMenu'
    }

    Behavior on width { PropertyAnimation { duration: 500 } }
    Behavior on height { PropertyAnimation { easing.type: Easing.OutBounce; duration: 1000 } }

    state: 'mainMenu'
    states: [
        State {
            name: 'mainMenu'
            PropertyChanges {
                target: menu
                width: 500
                height: 416 + 115
            }
            PropertyChanges {
                target: mainMenuContainer
                opacity: 1
            }
            PropertyChanges {
                target: aboutMenuContainer
                opacity: 0
            }
            PropertyChanges {
                target: imageTitleAbout
                scale: 4
            }
        },
        State {
            name: 'aboutMenu'
            PropertyChanges {
                target: menu
                width: 600
                height: 600 + 115
            }
            PropertyChanges {
                target: mainMenuContainer
                opacity: 0
            }
            PropertyChanges {
                target: aboutMenuContainer
                opacity: 1
            }
            PropertyChanges {
                target: imageTitle
                scale: .25
            }
        }
    ]
}
