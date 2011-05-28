
QT += declarative

SOURCES += src/main.cpp

SOURCES += src/qdeclarativetoucharea.cpp
HEADERS += src/qdeclarativetoucharea.h

RESOURCES += mong.qrc

unix {
  isEmpty(PREFIX) {
    PREFIX = /usr
  }

  BINDIR = $$PREFIX/bin
  DATADIR = $$PREFIX/share

  INSTALLS += target desktop icon64

  target.path = $$BINDIR

  desktop.path = $$DATADIR/applications
  desktop.files += $${TARGET}.desktop

  icon64.path = $$DATADIR/icons/hicolor/64x64/apps
  icon64.files += $${TARGET}.png
}

