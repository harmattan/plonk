#ifndef MONGVIEW_H
#define MONGVIEW_H

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
#include <QtDeclarative>

#include <sys/time.h>

#include "swipecontrol.h"
#include "config.h"

class MongView : public QDeclarativeView
{
    Q_OBJECT
public:
    MongView() : QDeclarativeView(), _active(true), _swipeControl(NULL) {
        /* Expose our QDeclarativeView as 'mongView' to QML */
        rootContext()->setContextProperty("mongView", this);
        /* Enable SwipeControl for locking swipe*/
        _swipeControl = new SwipeControl(this);
    }

    QString version() { return MONG_VERSION; }

    Q_PROPERTY(QString version READ version NOTIFY versionChanged)

    bool active() { return _active; }

    Q_PROPERTY(bool active READ active NOTIFY activeChanged)

    bool event(QEvent *event) {
        switch (event->type()) {
            case QEvent::Leave:
            case QEvent::WindowDeactivate:
                if (_active) {
                    _active = false;
                    emit activeChanged();
                }
                break;
            case QEvent::Enter:
            case QEvent::WindowActivate:
                if (!_active) {
                    _active = true;
                    emit activeChanged();
                }
                break;
            default:
                break;
        }

        return QDeclarativeView::event(event);
    }

    Q_INVOKABLE
    long currentTimeMillis() {
        /* Get the current time in milliseconds */
        struct timeval now;
        gettimeofday(&now, NULL);
        return (now.tv_sec*1000 + now.tv_usec/1000);
    }

    Q_INVOKABLE
    QPointF intersectBallPath(float paddleX1, float paddleY1,
                              float paddleX2, float paddleY2,
                              float ballOldX, float ballOldY,
                              float ballNewX, float ballNewY) {
        /* Check if (and where) the ball hit the paddle since the last step */
        QLineF paddleLine = QLineF(paddleX1, paddleY1, paddleX2, paddleY2);
        QLineF ballLine = QLineF(ballOldX, ballOldY, ballNewX, ballNewY);
        QPointF intersectionPoint;
        QLineF::IntersectType intersectionType;

        intersectionType = paddleLine.intersect(ballLine, &intersectionPoint);

        if (intersectionType == QLineF::BoundedIntersection) {
            return intersectionPoint;
        }

        return QPointF(-1, -1);
    }

    Q_INVOKABLE
    bool isSymbian() {
#if defined(Q_OS_SYMBIAN)
        return true;
#else
        return false;
#endif
    }

private:
    bool _active;
    SwipeControl *_swipeControl;
signals:
    void activeChanged();
    void versionChanged(); /* Should never be emitted ;) */

};

#endif // MONGVIEW_H
