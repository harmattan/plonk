
#include <QtCore>
#include <QtGui>
#include <QtDeclarative>

#include "qdeclarativetoucharea.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    /* Enable support for TouchArea and TouchPoint */
    QDeclarativeTouchArea::registerQML();

    /* Prepare the QML view and load the game content */
    QDeclarativeView view;
    view.setSource(QUrl("qrc:qml/pong/main.qml"));
    view.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    view.showFullScreen();


    return app.exec();
}

