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
    id: container

    height: 400
    width: 400

    property bool isForegroundApp: mongView.active

    onIsForegroundAppChanged: {
        if (!isForegroundApp) {
            /* Pause gameplay when switching to another task */
            playfield.state = "pause"
        }
    }

    Item {
        height: container.width
        width: container.height
        rotation: 270
        anchors.centerIn: parent

        Playfield {
            id: playfield
            anchors.fill: parent
        }

        Menu {
            anchors.centerIn: parent
            opacity: playfield.state == "pause" ? 1 : 0
            onPlayClicked: playfield.state = "play"
            onAboutClicked: console.log("About clicked")
        }
    }

}
