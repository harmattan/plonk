QT += qml quick

SOURCES += src/main.cpp

HEADERS += src/mongview.h
HEADERS += src/config.h

RESOURCES += plonk.qrc
QMAKE_RESOURCE_FLAGS += -threshold 0 -compress 9

