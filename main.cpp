#include <QtGui/QApplication>
#include <QDeclarativeContext>
#include <QUrl>

#include "qmlapplicationviewer.h"
#include "qdeclarativetoucharea.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    //QApplication::setGraphicsSystem("raster");

    qmlRegisterType<QDeclarativeTouchArea>("com.meego", 1, 0, "TouchArea");
    qmlRegisterType<QDeclarativeTouchPoint>("com.meego", 1, 0, "TouchPoint");

    QmlApplicationViewer viewer;

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setSource(QUrl("qrc:qml/pong/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
