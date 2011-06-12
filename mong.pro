
# Mong - A multi-touch pong-like game for MeeGo Tablets
# Copyright (C) 2011 Cornelius Hald, Thomas Perl, Tim Samoff
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


QT += declarative
QT += opengl

SOURCES += src/main.cpp

SOURCES += src/qdeclarativetoucharea.cpp
HEADERS += src/qdeclarativetoucharea.h

HEADERS += src/mongview.h
HEADERS += src/config.h

RESOURCES += mong.qrc

release.target = release
release.commands = sh utils/source_release.sh release

QMAKE_EXTRA_TARGETS += release

unix {
  isEmpty(PREFIX) {
    PREFIX = /usr
  }

  # MeeGo packaging and compliance guidelines
  # see http://appdeveloper.intel.com/en-us/article/meego-packaging-and-compliance-guidelines
  MEEGODIR = /opt/com.thpinfo.mong

  DATADIR = $$PREFIX/share

  target.path = $$MEEGODIR/bin

  desktop.path = $$DATADIR/applications
  desktop.files = mong.desktop

  icon.path = $$MEEGODIR
  icon.files = mong.png

  INSTALLS += target icon desktop
}

