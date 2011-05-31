
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
import QtMultimediaKit 1.1

Item {
    function playHit() {
        var index = Math.floor(Math.random()*4)
        switch (index) {
            case 0: hit1.play(); break;
            case 1: hit2.play(); break;
            case 2: hit3.play(); break;
            case 3: hit4.play(); break;
        }
    }

    SoundEffect { id: hit1; source: 'snd/hit1.wav' }
    SoundEffect { id: hit2; source: 'snd/hit2.wav' }
    SoundEffect { id: hit3; source: 'snd/hit3.wav' }
    SoundEffect { id: hit4; source: 'snd/hit4.wav' }

    function playOut() {
        var index = Math.floor(Math.random()*4)
        switch (index) {
            case 0: out1.play(); break;
            case 1: out2.play(); break;
            case 2: out3.play(); break;
            case 3: out4.play(); break;
        }
    }

    SoundEffect { id: out1; source: 'snd/out1.wav' }
    SoundEffect { id: out2; source: 'snd/out2.wav' }
    SoundEffect { id: out3; source: 'snd/out3.wav' }
    SoundEffect { id: out4; source: 'snd/out4.wav' }


    /* FIXME: in QtQuick 1.1, we can do it like that,
       but as of yet, we're using Qt 4.7 / QtQuick 1.0 :/

    function playHit() {
        var index = Math.floor(Math.random()*hitSounds.count)
        hitSounds.itemAt(index).play()
    }

    Repeater {
        id: hitSounds
        model: 4

        SoundEffect {
            source: 'snd/hit' + modelData + '.wav'
        }
    }
    */

}

