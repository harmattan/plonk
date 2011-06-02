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

class MongView : public QDeclarativeView
{
    Q_OBJECT

public:
    MongView() : QDeclarativeView(), _active(true) {}
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

private:
    bool _active;

signals:
    void activeChanged();

};

#endif // MONGVIEW_H
