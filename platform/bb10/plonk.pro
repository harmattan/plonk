include(plonk.pri)

HEADERS += src/blackberryeventfilter.h
SOURCES += src/blackberryeventfilter.cpp

# Needed for audio on Playbook
LIBS += -lstrm -lmmrndclient
