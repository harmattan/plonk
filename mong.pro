QT += declarative opengl

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

# Add more folders to ship with the application, here
# Adding them here also makes them show up in Qt Creators
# project view.
folder_01.source = qml/mong
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

for(deploymentfolder, DEPLOYMENTFOLDERS) {
    item = item$${deploymentfolder}
    itemsources = $${item}.sources
    $$itemsources = $$eval($${deploymentfolder}.source)
    itempath = $${item}.path
    $$itempath= $$eval($${deploymentfolder}.target)
    export($$itemsources)
    export($$itempath)
    DEPLOYMENT += $$item
}
