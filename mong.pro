
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

RESOURCES += mong.qrc

unix {
  isEmpty(PREFIX) {
    PREFIX = /usr
  }

  BINDIR = $$PREFIX/bin
  DATADIR = $$PREFIX/share

  INSTALLS += target desktop icon64

  target.path = $$BINDIR

  desktop.path = $$DATADIR/applications
  desktop.files += $${TARGET}.desktop

  icon64.path = $$DATADIR/icons/hicolor/64x64/apps
  icon64.files += $${TARGET}.png
}

# Add more folders to ship with the application, here
# Adding them here also makes them show up in Qt Creators
# project view.
folder_01.source = qml/mong
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

for(deploymentfolder, DEPLOYMENTFOLDERS) {
    item = item$${deploymentfolder}
    itemsources = $${item}.sources
    $$itemsources = $$eval($${deploymentfolder}.source)
    itempath = $${item}.path
    $$itempath= $$eval($${deploymentfolder}.target)
    export($$itemsources)
    export($$itempath)
    DEPLOYMENT += $$item
}
