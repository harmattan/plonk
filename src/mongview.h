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
//#include <QtDeclarative>
#include <QQmlContext>
#include <QtQuick/QQuickView>

#include <sys/time.h>

#ifdef Q_OS_BLACKBERRY
#include <QTimer>
#include <stdio.h>
#include <stdbool.h>
#include <unistd.h>
#include <sys/stat.h>
#include <mm/renderer.h>
#include <QFileInfo>
#include <sys/platform.h>
#include <bps/bps.h>
#include <bps/navigator.h>
#include <bps/event.h>
#endif

//#include "swipecontrol.h"
#include "config.h"

class MongView : public QQuickView
{
    Q_OBJECT
public:
    MongView() : QQuickView(), _active(true) {
        /* Expose our QDeclarativeView as 'mongView' to QML */
        rootContext()->setContextProperty("mongView", this);
        /* Enable SwipeControl for locking swipe*/
        //_swipeControl = new SwipeControl(this);
        #ifdef Q_OS_BLACKBERRY
        bps_initialize();
        //bps_set_verbosity(2);
        navigator_request_events(0);
        initAudio();
        m_bpsTimer.setSingleShot(false);
        m_bpsTimer.setInterval(500);
        m_bpsTimer.start();
        connect(&m_bpsTimer, SIGNAL(timeout()), this, SLOT(handleBpsEvents()));
        #endif
    }

    ~MongView() {
        #ifdef Q_OS_BLACKBERRY
        deinitAudio();
        bps_shutdown();
        #endif
    }

    QString version() { return MONG_VERSION; }

    Q_PROPERTY(QString version READ version NOTIFY versionChanged)

    bool active() { return _active; }

    Q_PROPERTY(bool active READ active NOTIFY activeChanged)

    bool event(QEvent *event) {
        qDebug() << "QT envent:" << event->type();
        switch (event->type()) {
            case QEvent::Leave:
            case QEvent::WindowDeactivate:
                qDebug() << "WINDOW DEACTIVATE";
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

        return QQuickView::event(event);
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

#ifdef Q_OS_BLACKBERRY
    Q_INVOKABLE
    void playHit() {
        char cwd[PATH_MAX];
        char input_url[PATH_MAX];

        int index = qrand() % ((4 + 1) - 1) + 1;
        getcwd(cwd, PATH_MAX);
        snprintf(input_url, PATH_MAX, "file://%s%s%d%s", cwd, "/app/native/snd/hit", index, ".wav");

        mmr_input_attach(m_ctxt, input_url, "track");
        mmr_play(m_ctxt);
    }

    Q_INVOKABLE
    void playOut() {
        char cwd[PATH_MAX];
        char input_url[PATH_MAX];

        int index = qrand() % ((4 + 1) - 1) + 1;
        getcwd(cwd, PATH_MAX);
        snprintf(input_url, PATH_MAX, "file://%s%s%d%s", cwd, "/app/native/snd/out", index, ".wav");

        mmr_input_attach(m_ctxt, input_url, "track");
        mmr_play(m_ctxt);
    }
#endif

private:
    bool _active;
    //SwipeControl *_swipeControl;
#ifdef Q_OS_BLACKBERRY
    mmr_context_t *m_ctxt;
    mmr_connection_t *m_connection;
    QTimer m_bpsTimer;

    void initAudio() {
        mode_t mode = S_IRUSR | S_IXUSR;
        m_connection = mmr_connect(NULL);
        m_ctxt = mmr_context_create(m_connection, "PlonkAudioPlayer", 0, mode);
        mmr_output_attach(m_ctxt, "audio:default", "audio");
    }

    void deinitAudio() {
        mmr_stop(m_ctxt);
        mmr_input_detach(m_ctxt);
        mmr_context_destroy(m_ctxt);
        mmr_disconnect(m_connection);
    }
#endif


private slots:
#ifdef Q_OS_BLACKBERRY
    void handleBpsEvents() {
        /*
         * For some reason we only get events during application startup. After that only
         * irelevant events are in the queue. Maybe Qt is filtering them away - not sure yet.
         */

        bps_event_t *event = NULL;

        for (;;) {
            int rc = bps_get_event(&event, 0);
            if (rc != BPS_SUCCESS) {
                qDebug() << "ERROR: bps_get_event() failed";
                event = NULL;
                break;
            }

            if (event) {
                int domain = bps_event_get_domain(event);
                if (domain == navigator_get_domain()) {

                    int code = bps_event_get_code(event);
                    qDebug() << "Got Navigator event: " << code;

                    if (code == NAVIGATOR_WINDOW_INACTIVE) {
                        _active = false;
                        emit activeChanged();

                    } else if (code == NAVIGATOR_WINDOW_ACTIVE) {
                        _active = true;
                        emit activeChanged();

                    } else if (code == NAVIGATOR_WINDOW_STATE) {
                        qDebug() << "---------------------------------------- Window state -----------------------";
                    }
                }
            } else {
                // exit for loop
                break;
            }
        }
    }
#endif


signals:
    void activeChanged();
    void versionChanged(); /* Should never be emitted ;) */

};

#endif // MONGVIEW_H
