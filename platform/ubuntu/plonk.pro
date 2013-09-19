include(plonk.pri)

DATADIR = $$PREFIX/share

target.path = $$PREFIX/bin

desktop.path = $$DATADIR/applications
desktop.files = plonk.desktop

icon.path = $$PREFIX/share/plonk
icon.files = plonk.png

INSTALLS += target icon desktop
