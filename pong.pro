
QT += opengl

SOURCES += main.cpp \
           qdeclarativetoucharea.cpp \
           touchareaplugin.cpp

HEADERS += qdeclarativetoucharea.h \
           touchareaplugin.h

RESOURCES += \
    pong.qrc

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qml/pong/main.qml \
    qml/pong/Paddle.qml \
    qml/pong/Ball.qml
