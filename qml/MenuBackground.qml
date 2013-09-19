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

// MenuBackground including the power button. This background will scale to
// almost any size without looking bad
Item {
    id: menuBackground

    property bool needPowerButton: false
    width:  500
    height: 500

    BorderImage {
        id: basePanel
        x: 0
        y: 100
        source: "img/menu/base.png"
        border {
            left: 100
            top: 100
            right: 100
            bottom: 100
        }
        anchors.fill: parent
        anchors.topMargin: 70
    }

    Image {
        id: topPanelShadow
        anchors.centerIn: topPanel
        anchors.verticalCenterOffset: -27
        source: "img/menu/base_top_shadow.png"
        visible: menuBackground.needPowerButton
    }

    Image {
        id: topPanel
        anchors.bottom: basePanel.top
        anchors.bottomMargin: -66
        anchors.horizontalCenter: basePanel.horizontalCenter
        source: "img/menu/base_top.png"
        visible: menuBackground.needPowerButton
    }

    Image {
        id: powerButtonOff
        source: "img/menu/btn_power_off.png"
        anchors.centerIn: topPanel
        anchors.verticalCenterOffset: -5
        visible: menuBackground.needPowerButton

        Image {
            id: powerButtonOn
            source: "img/menu/btn_power_on.png"
            opacity: powerButtonMouse.pressed ? 0 : 1
            anchors.centerIn: parent
        }

        MouseArea {
            id: powerButtonMouse
            anchors.fill: parent
            onClicked: Qt.quit()
        }
    }
}
