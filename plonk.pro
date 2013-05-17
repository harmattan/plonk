
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

QT += qml quick #multimedia

SOURCES += src/main.cpp

HEADERS += src/mongview.h
HEADERS += src/config.h

# Always compress resources
RESOURCES += plonk.qrc
QMAKE_RESOURCE_FLAGS += -threshold 0 -compress 9

!symbian {
    # Cleaner compile screen output
    #CONFIG += silent

    # Store object files in build/
    OBJECTS_DIR = build
    MOC_DIR = build
    RCC_DIR = build
}

# Declarative Touch Area
SOURCES +=
HEADERS +=

# Swipe Control
#DEPENDPATH += swipe
#INCLUDEPATH += swipe
#SOURCES += swipe/swipecontrol.cc
#HEADERS += swipe/swipecontrol.h

symbian {
    # Zombian - The Undead OS
    LIBS += -lcone -leikcore -lavkon

    DEPLOYMENT.display_name = "Plonk"
}

qnx {
    HEADERS += src/blackberryeventfilter.h
    SOURCES += src/blackberryeventfilter.cpp
    # Needed for audio on Playbook
    LIBS += -lstrm -lmmrndclient
}

#unix {
#  MEEGODIR = /opt/com.thpinfo.plonk
#  DATADIR = /usr/share
#
#  target.path = $$MEEGODIR/bin
#
#  desktop.path = $$DATADIR/applications
#  desktop.files = plonk.desktop
#
#  icon.path = $$MEEGODIR
#  icon.files = plonk.png
#
#  INSTALLS += target icon desktop
#}

android {
    OTHER_FILES += android/src/org/qtproject/qt5/android/bindings/QtActivity.java \
        android/src/org/qtproject/qt5/android/bindings/QtApplication.java \
        android/src/org/kde/necessitas/ministro/IMinistro.aidl \
        android/src/org/kde/necessitas/ministro/IMinistroCallback.aidl \
        android/AndroidManifest.xml \
        android/res/values/libs.xml \
        android/res/values/strings.xml \
        android/res/layout/splash.xml \
        android/res/values-et/strings.xml \
        android/res/values-zh-rCN/strings.xml \
        android/res/values-zh-rTW/strings.xml \
        android/res/values-es/strings.xml \
        android/res/values-nb/strings.xml \
        android/res/values-ms/strings.xml \
        android/res/values-it/strings.xml \
        android/res/values-pl/strings.xml \
        android/res/values-id/strings.xml \
        android/res/values-pt-rBR/strings.xml \
        android/res/values-rs/strings.xml \
        android/res/values-fr/strings.xml \
        android/res/values-ro/strings.xml \
        android/res/values-nl/strings.xml \
        android/res/values-de/strings.xml \
        android/res/values-ja/strings.xml \
        android/res/values-ru/strings.xml \
        android/res/values-fa/strings.xml \
        android/res/values-el/strings.xml \
        android/version.xml
}
