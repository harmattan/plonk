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

Image {
    id: menu
    signal playClicked
    signal aboutClicked

    source: "img/menu/base.png"

    Image {
        id: image1
        x: 57
        y: 37
        source: "img/menu/title.png"
    }

    MenuButton {
        id: playButton
        x: 72
        y: 168
        imageOff: "img/menu/btn_play_off.png"
        imageOn:  "img/menu/btn_play_on.png"
        onClicked: menu.playClicked()
    }

    MenuButton {
        id: aboutButton
        x: 73
        y: 262
        imageOff: "img/menu/btn_about_off.png"
        imageOn:  "img/menu/btn_about_on.png"
        onClicked: menu.aboutClicked
    }

}
