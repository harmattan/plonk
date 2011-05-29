#include <QtCore>
#include <QtGui>
#include <QtDeclarative>

#ifdef QT_OPENGL_LIB
# include <QGLWidget>
#endif

#include "qdeclarativetoucharea.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    /* Enable support for TouchArea and TouchPoint */
    QDeclarativeTouchArea::registerQML();

    QDeclarativeView view;

#ifdef QT_OPENGL_LIB
    /* Using OpenGL for increased performance */
    QGLFormat format = QGLFormat::defaultFormat();
    format.setSampleBuffers(true);
    QGLWidget *glWidget = new QGLWidget(format);
    glWidget->setAutoFillBackground(false);
    view.setViewport(glWidget);
#endif

    /* TODO: There might be settings for even better performance */
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

