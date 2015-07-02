include(plonk.pri)

TARGET = harbour-plonk

target.path = $$PREFIX/bin

desktop.path = $$PREFIX/share/applications
desktop.files = harbour-plonk.desktop

icon.path = $$PREFIX/share/harbour-plonk
icon.files = harbour-plonk.png

INSTALLS += target icon desktop
