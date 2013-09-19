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
    id: menu
    signal playClicked
    signal aboutClicked
    property int scoreRed: 0
    property int scoreBlue: 0

    MenuGear {
        id: gear
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        Behavior on anchors.bottomMargin { PropertyAnimation { duration: 500 } }
        onResetScore: {
            scoreRed = 0
            scoreBlue = 0
        }
    }

    MenuBackground {
        id: background

        anchors.fill: parent
        anchors.bottomMargin: 115

        Item {
            id: mainMenuContainer
            anchors.fill: parent
            anchors.topMargin: 30

            Behavior on opacity { PropertyAnimation { } }

            MenuButton {
                id: powerButton
                anchors.horizontalCenter: parent.horizontalCenter
                imageOff: "img/menu/btn_power_on.png"
                imageOn: "img/menu/btn_power_off.png"
                onClicked: Qt.quit()
                visible: background.needPowerButton
            }

            Image {
                id: imageTitle
                anchors.horizontalCenter: parent.horizontalCenter
                y: 40
                source: "img/menu/title.png"
                transformOrigin: Item.Top
                Behavior on scale { PropertyAnimation { } }
            }

            MenuButton {
                id: playButton
                anchors.horizontalCenter: parent.horizontalCenter
                y: 190
                imageOff: "img/menu/btn_play_off.png"
                imageOn:  "img/menu/btn_play_on.png"
                onClicked: menu.playClicked()
            }

            MenuButton {
                id: aboutButton
                anchors.horizontalCenter: parent.horizontalCenter
                y: 290
                imageOff: "img/menu/btn_about_off.png"
                imageOn:  "img/menu/btn_about_on.png"
                onClicked: menu.aboutClicked()
            }

            Row {
                id: matchCounter
                y: 390
                spacing: 50
                anchors.horizontalCenter: parent.horizontalCenter

                Image {
                    source: "img/menu/score_red.png"
                    Text {
                        font.pixelSize: 50
                        text: scoreRed
                        anchors.centerIn: parent
                    }
                }

                Image {
                    source: "img/menu/score_blue.png"
                    Text {
                        font.pixelSize: 50
                        text: scoreBlue
                        anchors.centerIn: parent
                    }
                }
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
                source: "img/menu/title.png"
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
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    textFormat: Text.RichText
                    font.pixelSize: 16
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    text: '<h1>Version ' + mongView.version + '</h1><p"><strong>Code:</strong> Cornelius Hald, Thomas Perl<br><br><strong>Artwork:</strong> Tim Samoff<br><br><strong>Sounds:</strong> Erik Stein<br><br><strong>Project name:</strong> Randall Arnold</p><br><p>Initially developed at the MeeGo Conference 2011 in San Francisco. Sound effects from the air hockey tables at the Hacker Lounge.</p>'
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
                height: 640
            }
            PropertyChanges {
                target: mainMenuContainer
                width: 500
                height: 600
                anchors.bottomMargin: -24
                opacity: 1
            }
            PropertyChanges {
                target: aboutMenuContainer
                opacity: 0
                enabled: false
            }
            PropertyChanges {
                target: imageTitleAbout
                scale: 4
            }
            PropertyChanges {
                target: gear
                anchors.bottomMargin: 0
            }

            PropertyChanges {
                target: imageTitle
                x: 57
                y: 91
                anchors.horizontalCenterOffset: 0
            }

            PropertyChanges {
                target: playButton
                x: 72
                y: 220
                anchors.horizontalCenterOffset: 1
            }

            PropertyChanges {
                target: aboutButton
                x: 73
                y: 321
                anchors.horizontalCenterOffset: 1
            }

            PropertyChanges {
                target: background
                width: 500
                height: 540
                anchors.bottomMargin: 85
            }

            PropertyChanges {
                target: matchCounter
                x: 124
                y: 415
                anchors.horizontalCenterOffset: 1
            }
        },
        State {
            name: 'aboutMenu'
            PropertyChanges {
                target: menu
                width: 500
                height: 715
            }
            PropertyChanges {
                target: mainMenuContainer
                opacity: 0
            }
            PropertyChanges {
                target: aboutMenuContainer
                opacity: 1
                enabled: true
            }
            PropertyChanges {
                target: imageTitle
                scale: .25
            }
            PropertyChanges {
                target: gear
                anchors.bottomMargin: 130
            }

            PropertyChanges {
                target: imageTitleAbout
                x: 196
                y: 119
                anchors.topMargin: 119
                anchors.horizontalCenterOffset: 1
            }
        }
    ]
}
