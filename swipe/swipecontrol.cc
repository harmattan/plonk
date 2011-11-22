
/**
 * SwipeControl class for Harmattan QML projects
 * Copyright (c) 2011 Thomas Perl <thp.io/about>
 * http://thp.io/2011/swipecontrol/
 **/

#include "swipecontrol.h"

#if !defined(Q_OS_SYMBIAN)
#  include <QX11Info>
#  include <X11/Xlib.h>
#  include <X11/Xatom.h>
#endif

SwipeControl::SwipeControl(QDeclarativeView *view, bool autoExpose)
    : QObject(view),
      _locked(false),
      _view(view)
{
    QSize size;
    size.setWidth(QApplication::desktop()->screenGeometry().width());
    size.setHeight(QApplication::desktop()->screenGeometry().height());
    view->resize(size);

    if (autoExpose) {
        view->rootContext()->setContextProperty("swipeControl", this);
    }

    updateLockedState();
}

void
SwipeControl::updateLockedState()
{
#if !defined(Q_OS_SYMBIAN)
    QRect rect(0, 0, 0, 0);

    if (_locked) {
        rect.setRect(_view->x(),
                     _view->y(),
                     _view->width(),
                     _view->height());
    }

    unsigned int customRegion[] = {
        rect.x(),
        rect.y(),
        rect.width(),
        rect.height()
    };

    Display *dpy = QX11Info::display();
    Atom customRegionAtom = XInternAtom(dpy,
            "_MEEGOTOUCH_CUSTOM_REGION", False);
    XChangeProperty(dpy, _view->winId(), customRegionAtom,
            XA_CARDINAL, 32, PropModeReplace,
            reinterpret_cast<unsigned char*>(&customRegion[0]), 4);
#endif
}

