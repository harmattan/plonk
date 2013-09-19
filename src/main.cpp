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

#include <QtCore>
#include <QGuiApplication>
#include <QtQuick/QQuickView>
#include <QQmlEngine>
#include <QObject>

#include "mongview.h"

#ifdef Q_OS_BLACKBERRY
#include <bps/navigator.h>
#endif

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    /* Use our Mong-specific QDeclarativeView with active window tracking */
    MongView view;
    view.setSource(QUrl("qrc:///qml/main.qml"));
    view.setResizeMode(QQuickView::SizeRootObjectToView);

#ifdef Q_OS_BLACKBERRY
    qDebug() << "Info: Starting Plonk on Blackberry";

    // Lock orientation into landscape mode
    // Next line only exist on BB10 not on Playbook
    navigator_set_orientation_mode(NAVIGATOR_LANDSCAPE, 0);
    navigator_rotation_lock(true);

    view.showFullScreen();
#else
    view.show();
#endif

    QObject::connect(view.engine(), SIGNAL(quit()), &app, SLOT(quit()));

    return app.exec();
}

