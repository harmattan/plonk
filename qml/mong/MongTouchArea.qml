
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
import com.meego 1.0

// The touch must originate inside the paddle otherwise it's ignored.
// Because of the offset, it's also possible to grab the paddle at the left or right end.
TouchArea {
    id: touchArea

    /* Enabled or disabled? (disable while in menu, etc..) */
    property bool enabled: true

    /* True while the paddle is touched */
    property bool paddleTouched: false

    /* Assign this to the paddle controlled by this touch area */
    property variant paddle: undefined


    /* Variables for private use by this area - not a public API! */
    property int offsetXStart: 0

    touchPoints: [
        TouchPoint {
            id: touchPoint
            onXChanged: {
                if (touchArea.paddleTouched && touchArea.enabled) {
                    var newX = touchPoint.x - touchArea.offsetXStart
                    if (Math.abs(newX - touchArea.paddle.x) > 3) {
                        touchArea.paddle.x = newX
                    }
                }
            }
        }
    ]

    onTouchStart: {
        if (touchArea.paddle.x < touchPoint.x &&
            touchPoint.x < touchArea.paddle.x + touchArea.paddle.width) {
            touchArea.offsetXStart = touchPoint.x - touchArea.paddle.x
            touchArea.paddleTouched = true
        }
    }

    onTouchEnd: {
        touchArea.paddleTouched = false
    }
}

