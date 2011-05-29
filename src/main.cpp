#include <QtCore>
#include <QtGui>
#include <QtDeclarative>
#include <QGLWidget>

#include "qdeclarativetoucharea.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    /* Enable support for TouchArea and TouchPoint */
    QDeclarativeTouchArea::registerQML();

    /* Using OpenGL for increased performance */
    QDeclarativeView view;
    QGLFormat format = QGLFormat::defaultFormat();
    format.setSampleBuffers(true);
    QGLWidget *glWidget = new QGLWidget(format);
    glWidget->setAutoFillBackground(false);

    /* TODO: There might be settings for even better performance */
    view.setViewport(glWidget);
    view.setViewportUpdateMode(QGraphicsView::FullViewportUpdate);
    view.setAttribute(Qt::WA_OpaquePaintEvent);
    view.setAttribute(Qt::WA_NoSystemBackground);
    view.viewport()->setAttribute(Qt::WA_OpaquePaintEvent);
    view.viewport()->setAttribute(Qt::WA_NoSystemBackground);

    /* Prepare the QML view and load the game content */
    view.setSource(QUrl("qrc:qml/mong/main.qml"));
    view.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    view.showFullScreen();

    return app.exec();
}

