#ifndef BLACKBERRYEVENTFILTER_H
#define BLACKBERRYEVENTFILTER_H

#include <QObject>
#include <QtCore/QAbstractNativeEventFilter>

class BlackberryEventFilter : public QObject, public QAbstractNativeEventFilter
{
    Q_OBJECT

public:
    explicit BlackberryEventFilter(QObject *parent = 0);
    bool nativeEventFilter(const QByteArray &eventType, void *message, long *result);
    
signals:
    void windowActive();
    void windowInactive();
    
public slots:
    
};

#endif // BLACKBERRYEVENTFILTER_H
