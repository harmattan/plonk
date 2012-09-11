#include <QDebug>
#include <bps/navigator.h>

#include "blackberryeventfilter.h"

BlackberryEventFilter::BlackberryEventFilter(QObject *parent) :
    QObject(parent)
{
}

bool BlackberryEventFilter::nativeEventFilter(const QByteArray &eventType, void *message, long *result)
{
    Q_UNUSED(eventType);
    Q_UNUSED(result);

    bps_event_t * const event = static_cast<bps_event_t *>(message);

    // Check if it is a navigator event
    if (!event || (bps_event_get_domain(event) != navigator_get_domain())) {
        return false;
    }

    unsigned int code = bps_event_get_code(event);

    switch (code) {

    case NAVIGATOR_WINDOW_INACTIVE:
        break;

    case NAVIGATOR_WINDOW_ACTIVE:
        break;

    case NAVIGATOR_WINDOW_STATE:
        navigator_window_state_t state = navigator_event_get_window_state(event);
        if (state == NAVIGATOR_WINDOW_FULLSCREEN) {
            emit windowActive();
        } else {
            emit windowInactive();
        }
        break;
    }

    // Don't stop event from beeing processed further
    return false;
}
