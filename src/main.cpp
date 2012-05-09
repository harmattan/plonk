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

#include "mongview.h"

#ifdef Q_OS_SYMBIAN
#  include <AknAppUi.h>
#endif

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    /* Force landscape mode on that undead OS */
#ifdef Q_OS_SYMBIAN
    CAknAppUi* appUi = dynamic_cast<CAknAppUi*> (CEikonEnv::Static()->AppUi());
    TRAPD(error,
    if (appUi) {
        // Lock application orientation into landscape
        appUi->SetOrientationL(CAknAppUi::EAppUiOrientationLandscape);
    }
    );
#endif

    /* Use our Mong-specific QDeclarativeView with active window tracking */
    MongView view;

#ifdef Q_OS_QNX
    qDebug() << "Starting on QNX";
    // On QNX Qt5 resources don't seem to work properly
    view.setSource(QUrl::fromLocalFile("app/native/qml/mong/main.qml"));
    // On QNX Qt5 next line don't seem to work either
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.showFullScreen();
#else
    view.setSource(QUrl("qrc:qml/mong/main.qml"));
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.show();
#endif

    QObject::connect(view.engine(), SIGNAL(quit()), &app, SLOT(quit()));

    return app.exec();
}

